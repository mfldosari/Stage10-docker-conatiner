##########################
# Key Vault Resource
##########################

resource "azurerm_key_vault" "kv" {
  # Basic Information
  name                        = var.keyvault_name        # The name of the Key Vault
  location                    = var.location             # The location for the Key Vault
  resource_group_name         = var.rg_name              # The resource group where the Key Vault will be placed
  tenant_id                   = var.tenant_id            # The tenant ID associated with the Key Vault
  
  # SKU and Access Configuration
  sku_name                    = "standard"               # SKU of the Key Vault (Standard or Premium)
  enable_rbac_authorization   = true                     # Enabling RBAC (Role-Based Access Control)

  # Soft Delete and Purge Protection
  soft_delete_retention_days  = 90                       # Number of days to retain soft-deleted items
  purge_protection_enabled    = true                     # Enable purge protection to prevent accidental deletion
  
  # Network Access Configuration
  public_network_access_enabled = true                  # Allow public network access to the Key Vault

  # Tags
  tags = {
    managed_by = "terraform"                             # Tag to indicate management by Terraform
  }
}

##########################
# IAM Role Assignment (Self) and (VMSS)
##########################

# Assign Key Vault Administrator role to self
resource "azurerm_role_assignment" "kv_admin" {
  principal_id         = var.my_object_id             # Object ID of the principal (user/identity)
  role_definition_name = "Key Vault Administrator"    # Role assignment for Key Vault Administrator
  scope                = azurerm_key_vault.kv.id      # The scope of the role assignment (Key Vault)
}

##########################
# Key Vault Access for Other Resources (FastAPI, VM)
##########################

# Assign Key Vault Secret User role to FastAPI container for accessing Key Vault
resource "azurerm_role_assignment" "fastapi_keyvault_access" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"     # Role for accessing Key Vault secrets
  principal_id         = var.fastapi_container_id     # FastAPI container ID (managed identity)
}

# Assign Key Vault Secret User role to VM for accessing Key Vault
resource "azurerm_role_assignment" "vm_keyvault_access" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"     # Role for accessing Key Vault secrets
  principal_id         = var.vm_id                    # VM's managed identity
}


##########################
# Key Vault Secrets
##########################

# Define and store sensitive database information in Key Vault as secrets

resource "azurerm_key_vault_secret" "dbname" {
  name         = "PROJ-DB-NAME"                       # Name of the secret for the database name
  value        = var.PROJ_DB_NAME                     # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "dbuser" {
  name         = "PROJ-DB-USER"                       # Name of the secret for the database username
  value        = var.PROJ_DB_USER                     # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "dbpassword" {
  name         = "PROJ-DB-PASSWORD"                   # Name of the secret for the database password
  value        = var.PROJ_DB_PASSWORD                 # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "dbhost" {
  name         = "PROJ-DB-HOST"                       # Name of the secret for the database host
  value        = var.PROJ_DB_HOST                     # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "dbport" {
  name         = "PROJ-DB-PORT"                       # Name of the secret for the database port
  value        = var.PROJ_DB_PORT                     # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "openai_key" {
  name         = "PROJ-OPENAI-API-KEY"                # Name of the secret for the OpenAI API key
  value        = var.PROJ_OPENAI_API_KEY              # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "sas_url" {
  name         = "PROJ-AZURE-STORAGE-SAS-URL"         # Name of the secret for the Azure Storage SAS URL
  value        = var.PROJ_AZURE_STORAGE_SAS_URL       # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "container_name" {
  name         = "PROJ-AZURE-STORAGE-CONTAINER"       # Name of the secret for the storage container name
  value        = var.PROJ_AZURE_STORAGE_CONTAINER     # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "chroma_host" {
  name         = "PROJ-CHROMADB-HOST"                 # Name of the secret for the Chroma DB host
  value        = var.PROJ_CHROMADB_HOST               # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "chroma_port" {
  name         = "PROJ-CHROMADB-PORT"                 # Name of the secret for the Chroma DB port
  value        = var.PROJ_CHROMADB_PORT               # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "COSMOSDB-ENDPOINT" {
  name         = "PROJ-COSMOSDB-ENDPOINT"             # Name of the secret for the Cosmos DB endpoint
  value        = var.PROJ_COSMOSDB_ENDPOINT           # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "COSMOSDB_key" {
  name         = "PROJ-COSMOSDB-KEY"                  # Name of the secret for the Cosmos DB key
  value        = var.PROJ_COSMOSDB_KEY                # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "COSMOSDB_DATABASE" {
  name         = "PROJ-COSMOSDB-DATABASE"             # Name of the secret for the Cosmos DB database
  value        = var.PROJ_COSMOSDB_DATABASE           # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "COSMOSDB_CONTAINER" {
  name         = "PROJ-COSMOSDB-CONTAINER"            # Name of the secret for the Cosmos DB container
  value        = var.PROJ_COSMOSDB_CONTAINER          # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
}

resource "azurerm_key_vault_secret" "AZURE-CONTAINER-APP-URL" {
  name         = "PROJ-AZURE-CONTAINER-APP-URL"       # Name of the secret for the Azure Container App URL
  value        = var.PROJ_AZURE_CONTAINER_APP_URL     # Value for the secret (from variable)
  key_vault_id = azurerm_key_vault.kv.id              # Reference to the Key Vault
  depends_on = [azurerm_role_assignment.kv_admin]     # Ensure the role assignment is applied before this
} 
