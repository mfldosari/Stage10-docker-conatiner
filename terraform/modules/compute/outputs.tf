
output "fastapi_container_id" {
  value = azurerm_container_app.fastapi_app.identity[0].principal_id
}

output "url_fastapi_https" {
  value = azurerm_container_app.fastapi_app.latest_revision_fqdn
}

output "vm_principal_id" {
value = azurerm_linux_virtual_machine.this.identity[0].principal_id
}
