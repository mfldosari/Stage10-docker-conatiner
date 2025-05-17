##########################
# Variable Definitions
##########################

# Azure Key Vault Name
variable "keyvault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

# Resource Group Name
variable "rg_name" {
  description = "The resource group name"
  type        = string
}

# Azure Location
variable "location" {
  description = "The Azure location for resources"
  type        = string
}

# Azure Tenant ID
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

# Azure AD Object ID for IAM access to Key Vault (yourself)
variable "my_object_id" {
  description = "Azure AD Object ID of the user (yourself)"
  type        = string
}

# Database Configuration
variable "PROJ_DB_NAME" {
  description = "The database name to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_DB_USER" {
  description = "The database username to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_DB_PASSWORD" {
  description = "The database password to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_DB_HOST" {
  description = "The database host to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_DB_PORT" {
  description = "The database port to store in Key Vault"
  type        = string
  sensitive   = true
}

# OpenAI API Key
variable "PROJ_OPENAI_API_KEY" {
  description = "The OpenAI API key to store in Key Vault"
  type        = string
  sensitive   = true
}


variable "PROJ_AZURE_STORAGE_CONTAINER" {
  description = "The Azure Storage Container to store in Key Vault"
  type        = string
  sensitive   = true
}

# ChromaDB Configuration
variable "PROJ_CHROMADB_HOST" {
  description = "The ChromaDB host to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_CHROMADB_PORT" {
  description = "The ChromaDB port to store in Key Vault"
  type        = string
  sensitive   = true
}

# CosmosDB Configuration
variable "PROJ_COSMOSDB_ENDPOINT" {
  description = "The CosmosDB endpoint to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_COSMOSDB_KEY" {
  description = "The CosmosDB key to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_COSMOSDB_DATABASE" {
  description = "The CosmosDB database to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "PROJ_COSMOSDB_CONTAINER" {
  description = "The CosmosDB container to store in Key Vault"
  type        = string
  sensitive   = true
}

# Azure Container App URL
variable "PROJ_AZURE_CONTAINER_APP_URL" {
  description = "The Azure Container App URL to store in Key Vault"
  type        = string
  sensitive   = true
}

# FastAPI container ID (for IAM role assignments)
variable "fastapi_container_id" {
  description = "FastAPI container ID"
  type        = string
}

# Virtual Machine ID (for IAM role assignments)
variable "vm_id" {
  description = "VM ID"
  type        = string
}
