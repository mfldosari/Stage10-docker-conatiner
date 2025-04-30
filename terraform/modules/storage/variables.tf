##########################
# General Variables
##########################

# Resource Group Name
variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

# Tag for resource management (to apply a common tag to resources)
variable "tag" {
  description = "A tag to apply for resource management"
  type        = string
}

# Azure Region (Location) for resource deployment
variable "location" {
  description = "The location where resources will be deployed"
  type        = string
}

# Storage Account Tier (e.g., Standard, Premium)
variable "storage_account_tier" {
  description = "The tier of the storage account"
  type        = string
}

# Storage Account Replication Type (e.g., LRS, ZRS)
variable "storage_account_replication_type" {
  description = "The replication type for the storage account"
  type        = string
}

# Container Access Type (e.g., private, public)
variable "container_access_type" {
  description = "The access type for the storage container"
  type        = string
}

variable "container_date" {
  description = "Start and end date for the SAS token"
  type = map(string)
}


##########################
# Storage Variables
##########################

# Storage Account Name
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

# Storage Container Name
variable "storage_container_name" {
  description = "The name of the storage container"
  type        = string
}
