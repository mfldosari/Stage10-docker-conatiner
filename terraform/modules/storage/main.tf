
##########################
# Storage Account Configuration
##########################

# Storage Account Resource
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  tags = {
    managed_by = var.tag
  }
}

# Storage Container Resource
resource "azurerm_storage_container" "this" {
  name                  = var.storage_container_name 
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.container_access_type

  depends_on = [azurerm_storage_account.this]
}


data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name

start  = var.container_date["start"]
expiry = var.container_date["end"]

  permissions {
    read   = true
    write  = true
    delete = true
    list   = true
    add    = true
    create = true
  }
  https_only = true
}