#!/bin/bash
# Accept arguments
STORAGE_ACCOUNT=$1
CONTAINER_NAME=$2
VAULT_NAME=$3
SECRET_NAME=$4
START=$5
EXPIRY=$6

az role assignment create \
  --assignee ****** \
  --role "Storage Blob Data Contributor" \
  --scope "/subscriptions/******/resourceGroups/tr-stage10-rg/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT"


SAS_TOKEN=$(az storage container generate-sas \
  --account-name "$STORAGE_ACCOUNT" \
  --name "$CONTAINER_NAME" \
  --permissions racwdli \
  --expiry 2025-05-22T00:00:00Z \
  --auth-mode login \
  --as-user \
  --https-only \
  --output tsv)


# Construct full SAS URL
FULL_URL="https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER_NAME}?${SAS_TOKEN}"
echo "$FULL_URL" > ./sas_url.txt

# Store the SAS URL in Key Vault
az keyvault secret set \
  --vault-name "$VAULT_NAME" \
  --name "$SECRET_NAME" \
  --value "$FULL_URL"
