module "resource_group" {
  # Resource group module to create and manage the resource group
  source   = "./modules/general/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

module "database" {
  # Database module to create and configure the database and Cosmos DB
  source                  = "./modules/database"
  rg_name                 = module.resource_group.rg_name
  db_location             = var.db_location
  db_password             = var.PROJ_DB_PASSWORD
  cosmosdb_account_name   = var.cosmosdb_account_name
  db_username             = var.PROJ_DB_USER
  cosmosdb_container_name = var.PROJ_COSMOSDB_CONATINER_NAME
  cosmosdb_database_name  = var.PROJ_COSMOSDB_DATABASE_NAME
}

module "storage" {
  depends_on = [ module.security ]
  # Storage module to create and configure Azure storage account and container
  source                           = "./modules/storage"
  rg_name                          = module.resource_group.rg_name
  location                         = module.resource_group.location
  storage_account_name             = var.storage_account_name
  storage_container_name           = var.storage_container_name
  keyvaultname                    = var.keyvault_name
}


module "compute" {
  # Compute module to configure virtual machines and container apps
  source                         = "./modules/compute"
  rg_name                        = module.resource_group.rg_name
  location                       = module.resource_group.location
  container_registry_sku         = var.container_registry_sku
  container_app_environment_name = var.container_app_environment_name
  container_apps_config          = var.container_apps_config
  container_registry_name        = var.container_registry_name
  tag                            = var.tag
  image_config                   = var.image_config
  vm_name                        = var.vm_name
  vm_size                        = var.vm_size
  admin_username                 = var.admin_username
  nic_id                         = module.network.nic_id
}

module "network" {
  # Network module to configure virtual network, subnets, and network interfaces
  source         = "./modules/network"
  rg_name        = module.resource_group.rg_name
  location       = module.resource_group.location
  subnet_name    = var.subnet_name
  subnet_prefixe = var.subnet_prefixe
  nic_name       = var.nic_name
  nsg_name       = var.nsg_name
  vnet_name      = var.vnet_name
  address_space  = var.address_space
}

module "security" {
  # Security module for assigning roles and securing resources
  source                       = "./modules/security"
  fastapi_container_id         = module.compute.fastapi_container_id
  rg_name                      = module.resource_group.rg_name
  location                     = module.resource_group.location
  vm_id                        = module.compute.vm_principal_id
  tenant_id                    = var.tenant_id
  my_object_id                 = var.object_id
  PROJ_AZURE_STORAGE_CONTAINER = var.storage_container_name
  PROJ_CHROMADB_HOST           = module.network.public_ip_address
  PROJ_COSMOSDB_DATABASE       = var.PROJ_COSMOSDB_DATABASE_NAME
  PROJ_COSMOSDB_CONTAINER      = var.PROJ_COSMOSDB_CONATINER_NAME
  PROJ_COSMOSDB_ENDPOINT       = module.database.cosmosdb_endpoint
  PROJ_COSMOSDB_KEY            = module.database.cosmosdb_primary_key
  PROJ_DB_HOST                 = module.database.database_endpoint
  PROJ_DB_NAME                 = var.PROJ_DB_NAME
  PROJ_DB_PASSWORD             = var.PROJ_DB_PASSWORD
  PROJ_DB_USER                 = var.PROJ_DB_USER
  PROJ_DB_PORT                 = var.PROJ_DB_PORT
  keyvault_name                = var.keyvault_name
  PROJ_OPENAI_API_KEY          = var.openai_key
  PROJ_AZURE_CONTAINER_APP_URL = "https://${module.compute.url_fastapi_https}/"
  PROJ_CHROMADB_PORT           = var.PROJ_CHROMADB_PORT
}

