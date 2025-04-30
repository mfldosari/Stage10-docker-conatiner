##########################
# Network Interface Outputs
##########################

output "nic_id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.this.id
}

##########################
# Public IP Address Outputs
##########################

output "public_ip_address" {
  description = "The public IP address assigned to the network interface"
  value       = azurerm_public_ip.this.ip_address
}