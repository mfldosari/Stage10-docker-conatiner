##########################
# Virtual Network Configuration
##########################

variable "vnet_name" {
  description = "The name of the virtual network"
}

variable "address_space" {
  description = "The address space of the virtual network"
}

##########################
# Subnet Configuration
##########################

variable "subnet_name" {
  description = "The name of the subnet"
}

variable "subnet_prefixe" {
  description = "The subnet address prefix"
}

##########################
# Resource Group and Location Configuration
##########################

variable "rg_name" {
  description = "The resource group name"
}

variable "location" {
  description = "The location of the resources"
}

##########################
# Network Interface and Security Group Configuration
##########################

variable "nic_name" {
  description = "The name of the network interface"
}

variable "nsg_name" {
  description = "The name of the network security group"
}