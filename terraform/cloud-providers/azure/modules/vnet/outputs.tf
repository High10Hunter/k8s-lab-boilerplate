# Virtual Network Outputs
output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "vnet_address_space" {
  description = "The address space of the virtual network."
  value       = azurerm_virtual_network.this.address_space
}

output "vnet_location" {
  description = "The location of the virtual network."
  value       = azurerm_virtual_network.this.location
}

output "resource_group_name" {
  description = "The name of the resource group."
  value       = azurerm_virtual_network.this.resource_group_name
}

# Legacy Subnet Outputs (for backward compatibility)
output "subnet_ids" {
  description = "The IDs of the legacy subnets."
  value       = azurerm_subnet.subnets[*].id
}

output "subnet_names" {
  description = "The names of the legacy subnets."
  value       = azurerm_subnet.subnets[*].name
}

# Private Subnet Outputs
output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = azurerm_subnet.private_subnets[*].id
}

output "private_subnet_names" {
  description = "The names of the private subnets."
  value       = azurerm_subnet.private_subnets[*].name
}

output "private_subnet_address_prefixes" {
  description = "The address prefixes of the private subnets."
  value       = azurerm_subnet.private_subnets[*].address_prefixes
}

# Public Subnet Outputs
output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = azurerm_subnet.public_subnets[*].id
}

output "public_subnet_names" {
  description = "The names of the public subnets."
  value       = azurerm_subnet.public_subnets[*].name
}

output "public_subnet_address_prefixes" {
  description = "The address prefixes of the public subnets."
  value       = azurerm_subnet.public_subnets[*].address_prefixes
}

# Route Table Outputs
output "private_route_table_id" {
  description = "The ID of the private route table."
  value       = var.create_private_route_table && length(var.private_subnets) > 0 ? azurerm_route_table.private[0].id : null
}

output "private_route_table_name" {
  description = "The name of the private route table."
  value       = var.create_private_route_table && length(var.private_subnets) > 0 ? azurerm_route_table.private[0].name : null
}

output "public_route_table_id" {
  description = "The ID of the public route table."
  value       = var.create_public_route_table && length(var.public_subnets) > 0 ? azurerm_route_table.public[0].id : null
}

output "public_route_table_name" {
  description = "The name of the public route table."
  value       = var.create_public_route_table && length(var.public_subnets) > 0 ? azurerm_route_table.public[0].name : null
}

# Route Table Association Outputs
output "private_route_table_association_ids" {
  description = "The IDs of the private subnet route table associations."
  value       = azurerm_subnet_route_table_association.private[*].id
}

output "public_route_table_association_ids" {
  description = "The IDs of the public subnet route table associations."
  value       = azurerm_subnet_route_table_association.public[*].id
}

# Combined Outputs
output "all_subnet_ids" {
  description = "All subnet IDs (legacy, private, and public)."
  value = concat(
    azurerm_subnet.subnets[*].id,
    azurerm_subnet.private_subnets[*].id,
    azurerm_subnet.public_subnets[*].id
  )
}

output "all_subnet_names" {
  description = "All subnet names (legacy, private, and public)."
  value = concat(
    azurerm_subnet.subnets[*].name,
    azurerm_subnet.private_subnets[*].name,
    azurerm_subnet.public_subnets[*].name
  )
}

# Summary Output for Easy Reference
output "network_summary" {
  description = "A summary of the created network resources."
  value = {
    vnet_id                    = azurerm_virtual_network.this.id
    vnet_name                  = azurerm_virtual_network.this.name
    vnet_address_space         = azurerm_virtual_network.this.address_space
    private_subnets_count      = length(azurerm_subnet.private_subnets)
    public_subnets_count       = length(azurerm_subnet.public_subnets)
    legacy_subnets_count       = length(azurerm_subnet.subnets)
    private_route_table_exists = var.create_private_route_table && length(var.private_subnets) > 0
    public_route_table_exists  = var.create_public_route_table && length(var.public_subnets) > 0
  }
}