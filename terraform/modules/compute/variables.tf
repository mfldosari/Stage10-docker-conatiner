######################################
# Virtual Machine Configuration
######################################

variable "vm_name" {
  description = "Name of the virtual machine"
}

variable "rg_name" {
  description = "Name of the resource group for the VM"
}

variable "location" {
  description = "Azure region for resource deployment"
}

variable "vm_size" {
  description = "Size of the virtual machine (e.g., Standard_DS1_v2)"
}

variable "admin_username" {
  description = "Admin username for VM login"
}

variable "nic_id" {
  description = "Network Interface ID to associate with the VM"
}

######################################
# Container Registry Configuration
######################################

variable "container_registry_name" {
  description = "Name of the Azure Container Registry (ACR)"
}

variable "container_registry_sku" {
  description = "SKU (pricing tier) for the ACR"
}

######################################
# Resource Tagging
######################################

variable "tag" {
  description = "Tag to apply to resources for organization/management"
}

######################################
# Docker Image Build Configuration
######################################

variable "image_config" {
  description = "List of Docker image build configurations"
  type = list(object({
    image_name = string   # Docker image name (e.g., fastapi-app)
    version    = string   # Docker image version (e.g., v1)
    path       = string   # Build context path
  }))
}

######################################
# Azure Container Apps Configuration
######################################

variable "container_app_environment_name" {
  description = "Name of the Azure Container Apps environment"
}

variable "container_apps_config" {
  description = "List of configurations for each Azure Container App"
  type = list(object({
    name          = string  # Container App name
    revision_mode = string  # Revision mode (e.g., Single)
    cpu           = number  # CPU allocation
    memory        = string  # Memory allocation (e.g., 1Gi)
    target_port   = number  # App listening port
    transport     = string  # Transport protocol (e.g., auto)
    secret_name   = string  # Secret name for ACR authentication
  }))
}
