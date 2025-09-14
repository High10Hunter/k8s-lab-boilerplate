# Legacy subnets (for backward compatibility)
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  address_prefixes     = var.subnets[count.index].address_prefixes
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}

# Private Subnets
resource "azurerm_subnet" "private_subnets" {
  count                = length(var.private_subnets)
  name                 = var.private_subnets[count.index].name
  address_prefixes     = var.private_subnets[count.index].address_prefixes
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}

# Public Subnets
resource "azurerm_subnet" "public_subnets" {
  count                = length(var.public_subnets)
  name                 = var.public_subnets[count.index].name
  address_prefixes     = var.public_subnets[count.index].address_prefixes
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}
