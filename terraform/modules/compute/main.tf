##########################
# Linux Virtual Machine (VM) Resource
##########################

# Define an Azure Linux Virtual Machine with the provided configuration
resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    var.nic_id,
  ]

  # Admin SSH key for secure access to the VM
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub") 
  }

  # OS disk configuration (Standard_LRS for redundant storage)
  os_disk {
    caching              = "ReadWrite" 
    storage_account_type = "Standard_LRS"  
  }

  # Source image configuration (Ubuntu 22.04 LTS)
  source_image_reference {
    publisher = "Canonical"  
    offer     = "0001-com-ubuntu-server-jammy" 
    sku       = "22_04-lts" 
    version   = "latest"  
  }

  # Enable managed identity for the VM
  identity {
    type = "SystemAssigned"  
  }
  custom_data = filebase64("${path.module}/cloud-init.yaml")
}

#################################
# Terraform Provider Configuration
#################################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.64.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

#################################
# Azure Container Registry
#################################
resource "azurerm_container_registry" "this" {
  name                = var.container_registry_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.container_registry_sku
  admin_enabled       = true

  tags = {
    managed_by = var.tag
  }
}

#################################
# Docker Provider Configuration
#################################
provider "docker" {
  host = "unix:///var/run/docker.sock"

  # Authenticate Docker to Azure Container Registry
  registry_auth {
    address  = azurerm_container_registry.this.login_server
    username = azurerm_container_registry.this.admin_username
    password = azurerm_container_registry.this.admin_password
  }
}

#################################
# Build and Push FastAPI Docker Image
#################################
resource "docker_image" "fastapi_image" {
  name = "${azurerm_container_registry.this.login_server}/${var.image_config[0].image_name}:${var.image_config[0].version}"

  build {
    path = var.image_config[0].path
  }
}

resource "docker_registry_image" "fastapi_image_push" {
  name          = docker_image.fastapi_image.name
  keep_remotely = true
}


#################################
# Create Container Apps Environment
#################################
resource "azurerm_container_app_environment" "this" {

  name                = var.container_app_environment_name
  location            = var.location
  resource_group_name = var.rg_name

  tags = {
    managed_by = var.tag
  }
}

#################################
# Deploy FastAPI Container App
#################################
resource "azurerm_container_app" "fastapi_app" {
  name                         = var.container_apps_config[0].name
  resource_group_name          = var.rg_name
  container_app_environment_id = azurerm_container_app_environment.this.id
  revision_mode                = var.container_apps_config[0].revision_mode

  template {
    container {
      name   = var.container_apps_config[0].name
      image  = docker_registry_image.fastapi_image_push.name
      cpu    = var.container_apps_config[0].cpu
      memory = var.container_apps_config[0].memory
    }
  }

  # Enable Managed Identity
  identity {
    type = "SystemAssigned"
  }

  ingress {
    external_enabled           = true
    target_port                = var.container_apps_config[0].target_port
    transport                  = var.container_apps_config[0].transport
    allow_insecure_connections = false

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  # Store ACR password as secret
  secret {
    name  = var.container_apps_config[0].secret_name
    value = azurerm_container_registry.this.admin_password
  }

  # Configure registry using the stored secret
  registry {
    server               = azurerm_container_registry.this.login_server        
    username             = azurerm_container_registry.this.admin_username 
    password_secret_name = var.container_apps_config[0].secret_name
  }

  tags = {
    managed_by = var.tag
  }

  depends_on = [
    azurerm_container_app_environment.this,
    azurerm_linux_virtual_machine.this
  ]
}
