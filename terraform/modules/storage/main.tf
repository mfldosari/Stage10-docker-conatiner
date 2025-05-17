
##########################
# Storage Account Configuration
##########################

# Storage Account Resource
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

# Storage Container Resource
resource "azurerm_storage_container" "this" {
  name                  = var.storage_container_name 
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.this]
}

resource "azurerm_storage_blob" "pdf_store" {
  name                   = "pdf_store/"               # Blob name
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"

  depends_on = [azurerm_storage_container.this]
}

resource "null_resource" "generate_sas_url" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = <<EOT
bash ${path.module}/sas.sh \
  ${azurerm_storage_account.this.name} \
  ${azurerm_storage_container.this.name} \
  ${var.keyvaultname}\
  PROJ-AZURE-STORAGE-SAS-URL \
  2025-05-16T20:34:52Z \
  2025-05-22T04:34:52Z
EOT
  }

  depends_on = [azurerm_storage_container.this]
}

