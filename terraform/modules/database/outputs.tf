output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_primary_key" {
  value     = azurerm_cosmosdb_account.this.primary_key
  sensitive = true
}

output "database_endpoint" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}