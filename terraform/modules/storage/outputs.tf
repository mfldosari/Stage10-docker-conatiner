output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "sas_url" {
  description = "SAS URL for the container"
  value       = "https://${azurerm_storage_account.this.name}.blob.core.windows.net/${azurerm_storage_container.this.name}?${data.azurerm_storage_account_blob_container_sas.this.sas}"
}