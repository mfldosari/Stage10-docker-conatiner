# General Variables
variable "rg_name"                         { default = "<rg_name>" }                         # Resource Group Name
variable "location"                        { default = "<location>" }                        # Azure Location
variable "subscription_id"                { default = "<subscription_id>" }                # Azure Subscription ID
variable "tenant_id"                      { default = "<tenant_id>" }                      # Azure Tenant ID
variable "object_id"                      { default = "<object_id>" }                      # Azure Object ID for IAM
variable "tag"                            { default = "<tag>" }                            # Tag for Resource Management
variable "openai_key"                     { default = "<openai_key>" }                     # OpenAI API Key

###################################################################################

# Database Credentials
variable "PROJ_DB_USER"                   { default = "<PROJ_DB_USER>" }                   # The username for the database
variable "db_location"                    { default = "<db_location>" }                    # The location for the database
variable "PROJ_DB_PASSWORD"              { default = "<PROJ_DB_PASSWORD>" }              # The password for the database
variable "cosmosdb_account_name"         { default = "<cosmosdb_account_name>" }         # Name of the Cosmos DB account
variable "PROJ_COSMOSDB_DATABASE_NAME"   { default = "<PROJ_COSMOSDB_DATABASE_NAME>" }   # Cosmos DB SQL database name
variable "PROJ_COSMOSDB_CONATINER_NAME"  { default = "<PROJ_COSMOSDB_CONATINER_NAME>" }  # Cosmos DB SQL container name
variable "PROJ_CHROMADB_PORT"            { default = "<PROJ_CHROMADB_PORT>" }            # Chromadb port

###################################################################################

# Storage Configuration
variable "storage_account_tier"          { default = "<storage_account_tier>" }          # Storage account tier
variable "storage_account_replication_type" { default = "<storage_account_replication_type>" } # Storage account replication type
variable "container_access_type"         { default = "<container_access_type>" }         # Container access type (private/public)

variable "container_date" {
  description = "Start and end date for the SAS token"
  type        = map(string)
  default = {
    start = "<start_date>"
    end   = "<end_date>"
  }
}

variable "storage_account_name"          { default = "<storage_account_name>" }          # Name of the storage account
variable "storage_container_name"        { default = "<storage_container_name>" }        # Name of the storage container

###################################################################################

# Virtual Machine Configuration
variable "vm_name"                        { default = "<vm_name>" }                        # Virtual Machine Name
variable "vm_size"                        { default = "<vm_size>" }                        # Virtual Machine Size
variable "admin_username"                { default = "<admin_username>" }                # VM Admin Username

###################################################################################

# Container Registry Configuration
variable "container_registry_name"       { default = "<container_registry_name>" }       # Azure Container Registry Name
variable "container_registry_sku"        { default = "<container_registry_sku>" }        # Azure Container Registry SKU

###################################################################################

# Docker Image Configuration
variable "image_config" {
  type = list(object({
    image_name = string
    version    = string
    path       = string
  }))
  default = [
    { image_name = "<image_name>", version = "<version>", path = "<path>" }
  ]
}

###################################################################################

# Container Apps Configuration
variable "container_app_environment_name" { default = "<container_app_environment_name>" } # Container Apps Environment Name

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
    {
      name          = "<name>"
      revision_mode = "<revision_mode>"
      cpu           = 0.5
      memory        = "<memory>"
      target_port   = 8000
      transport     = "<transport>"
      secret_name   = "<secret_name>"
    }
  ]
}

###################################################################################

# Network Configuration
variable "vnet_name"           { default = "<vnet_name>" }           # Virtual Network Name
variable "address_space"       { default = ["<address_space>"] }     # Address space of the virtual network
variable "subnet_name"         { default = "<subnet_name>" }         # Subnet Name
variable "subnet_prefixe"      { default = ["<subnet_prefixe>"] }    # Subnet address prefix

###################################################################################

# Network Interface and Security Group Configuration
variable "nic_name"            { default = "<nic_name>" }            # Network Interface Name
variable "nsg_name"            { default = "<nsg_name>" }            # Network Security Group Name

###################################################################################

# Key Vault Configuration
variable "keyvault_name"       { default = "<keyvault_name>" }       # Azure Key Vault Name
variable "PROJ_DB_PORT"        { default = "<PROJ_DB_PORT>" }        # Database port
variable "PROJ_DB_NAME"        { default = "<PROJ_DB_NAME>" }        # Database name
