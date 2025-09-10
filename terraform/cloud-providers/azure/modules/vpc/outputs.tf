# Virtual Network Outputs
output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

# Subnet Outputs
output "subnet_ids" {
  description = "The IDs of the subnets."
  value       = azurerm_subnet.subnets[*].id
}

output "subnet_names" {
  description = "The names of the subnets."
  value       = azurerm_subnet.subnets[*].name
}
