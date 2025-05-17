# General Variables
variable "rg_name"                { default = "<your-resource-group-name>" }
variable "location"              { default = "<your-location>" }
variable "subscription_id"       { default = "<your-subscription-id>" }
variable "tenant_id"             { default = "<your-tenant-id>" }
variable "object_id"             { default = "<your-object-id>" }
variable "tag"                   { default = "<your-tag>" }
variable "openai_key"            { default = "<your-openai-api-key>" }

###################################################################################

# Database Credentials
variable "PROJ_DB_USER"          { default = "<your-db-username>" }
variable "db_location"          { default = "<your-db-location>" }
variable "PROJ_DB_PASSWORD"     { default = "<your-db-password>" }
variable "cosmosdb_account_name" { default = "<your-cosmosdb-account-name>" }
variable "PROJ_COSMOSDB_DATABASE_NAME" { default = "<your-cosmosdb-database>" }
variable "PROJ_COSMOSDB_CONATINER_NAME" { default = "<your-cosmosdb-container>" }
variable "PROJ_CHROMADB_PORT"   { default = "<your-chromadb-port>" }

###################################################################################

# Storage Configuration
variable "storage_account_tier" { default = "Standard" }
variable "storage_account_replication_type" { default = "LRS" }
variable "container_access_type" { default = "private" }
variable "container_date" {
  type = map(string)
  default = {
    start = "<start-date>"
    end   = "<end-date>"
  }
}

variable "storage_account_name" {
  default     = "<your-storage-account>"
  description = "The name of the storage account"
}
variable "storage_container_name" {
  default     = "<your-storage-container>"
  description = "The name of the storage container"
}

###################################################################################

# Virtual Machine Configuration
variable "vm_name"        { default = "<your-vm-name>" }
variable "vm_size"        { default = "<your-vm-size>" }
variable "admin_username" { default = "<your-admin-username>" }

###################################################################################

# Container Registry Configuration
variable "container_registry_name" { default = "<your-container-registry>" }
variable "container_registry_sku"  { default = "Basic" }

###################################################################################

# Docker Image Configuration
variable "image_config" {
  type = list(object({
    image_name = string
    version    = string
    path       = string
  }))
  default = [
    { image_name = "<your-image-name>", version = "<your-version>", path = "<your-image-path>" }
  ]
}

###################################################################################

# Container Apps Configuration
variable "container_app_environment_name" { default = "<your-app-environment>" }

variable "container_apps_config" {
  type = list(object({
    name          = string
    revision_mode = string
    cpu           = number
    memory        = string
    target_port   = number
    transport     = string
    secret_name   = string
  }))
  default = [
    { name = "<app-name>", revision_mode = "Single", cpu = 0.5, memory = "1.0Gi", target_port = 8000, transport = "auto", secret_name = "<your-secret-name>" }
  ]
}

###################################################################################

# Network Configuration
variable "vnet_name"      { default = "<your-vnet-name>" }
variable "address_space"  { default = ["<your-address-space>"] }

variable "subnet_name"    { default = "<your-subnet-name>" }
variable "subnet_prefixe" { default = ["<your-subnet-prefix>"] }

###################################################################################

# Network Interface and Security Group Configuration
variable "nic_name" { default = "<your-nic-name>" }
variable "nsg_name" { default = "<your-nsg-name>" }

###################################################################################

# Key Vault Configuration
variable "keyvault_name" { default = "<your-keyvault-name>" }

# DB Port and Name for Key Vault
variable "PROJ_DB_PORT" { default = "<your-db-port>" }
variable "PROJ_DB_NAME" { default = "<your-db-name>" }
