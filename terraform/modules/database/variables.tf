######################################
# Resource Group and Location
######################################

variable "rg_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "db_location" {
  description = "Azure region where the database resources will be deployed"
  type        = string
}

######################################
# PostgreSQL Database Credentials
######################################

variable "db_username" {
  description = "Administrator username for the PostgreSQL database"
  type        = string
}

variable "db_password" {
  description = "Administrator password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

######################################
# Cosmos DB Configuration
######################################

variable "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  type        = string
}

variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB SQL database"
  type        = string
}

variable "cosmosdb_container_name" {
  description = "Name of the Cosmos DB SQL container"
  type        = string
}
