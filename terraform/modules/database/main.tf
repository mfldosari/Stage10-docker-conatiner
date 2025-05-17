############################
# PostgreSQL Flexible Server
############################

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = "chatbot-database-sda-weclouddata"
  resource_group_name    = var.rg_name
  location               = var.db_location
  zone                   = "1"
  version                = "13"
  administrator_login    = var.db_username
  administrator_password = var.db_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
}

# Allow all IPs (for development only — not recommended for production)
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "allow_all_ips"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

# Local execution to create a table (requires psql locally)
resource "null_resource" "postgresql_setup" {
  depends_on = [ azurerm_postgresql_flexible_server.this ]
  triggers = {
    server = azurerm_postgresql_flexible_server.this.name
  }

  provisioner "local-exec" {
    command = <<EOT
PGPASSWORD='${var.db_password}' psql -h ${azurerm_postgresql_flexible_server.this.fqdn} -U ${var.db_username} -d postgres -c "
CREATE TABLE IF NOT EXISTS advanced_chats (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  file_path TEXT NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  pdf_path TEXT,
  pdf_name TEXT,
  pdf_uuid TEXT,
  image_url text NULL,
  image_name text NULL
);
"
EOT
  }
}

############################
# Cosmos DB Configuration
############################

resource "azurerm_cosmosdb_account" "this" {
  name                = var.cosmosdb_account_name
  resource_group_name = var.rg_name
  location            = var.db_location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.db_location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }

  backup {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_cosmosdb_sql_database" "this" {
  name                = var.cosmosdb_database_name
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.this.name
  # Removed throughput, as it's not supported for serverless accounts
}

resource "azurerm_cosmosdb_sql_container" "this" {
  name                  = var.cosmosdb_container_name 
  resource_group_name   = var.rg_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this.name
  partition_key_paths   = ["/definition/id"]
  partition_key_version = 1
  # Removed throughput, as it's not supported for serverless accounts

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
