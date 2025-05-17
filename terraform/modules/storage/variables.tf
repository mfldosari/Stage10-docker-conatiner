##########################
# General Variables
##########################

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where resources will be deployed"
  type        = string
}

##########################
# Storage Variables
##########################

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage account"
  type        = string
}

variable "keyvaultname" {
  description = "The name of Key vault"
  type        = string
}