output "IP" {
  value = module.network.public_ip_address
}
output "cosmodb_key" {
  value     = module.database.cosmosdb_primary_key
  sensitive = true
}
output "cosmodbendpoint" {
  value = module.database.cosmosdb_endpoint
  #sensitive = true
}
output "cosmodbdatabase" {
  value = var.PROJ_COSMOSDB_DATABASE_NAME
  #sensitive = true
}

output "cosmodbcaonatiner" {
  value = var.PROJ_COSMOSDB_CONATINER_NAME
  #sensitive = true
}

output "openaikey" {
  value = var.openai_key
  #sensitive = true
}
output "chroma_port" {
  value = var.PROJ_CHROMADB_PORT
  #sensitive = true
}

output "chroma_host" {
  value = module.network.public_ip_address
  #sensitive = true
}


output "storgaeaccuntconatinername" {
  value = var.storage_container_name
  #sensitive = true
}


output "databaseendpoint" {
  value = module.database.database_endpoint
  #sensitive = true
}

output "databaseusername" {
  value = var.PROJ_DB_USER
  #sensitive = true
}

output "databasepass" {
  value = var.PROJ_DB_PASSWORD
  sensitive = true
}

output "databasEPORT" {
  value = var.PROJ_DB_PORT
  #sensitive = true
}



output "PROJ_AZURE_CONTAINER_APP_URL" {
  value = "https://${module.compute.url_fastapi_https}"
}