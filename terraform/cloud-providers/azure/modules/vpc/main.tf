resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet" "subnets" {
  count               = length(var.subnets)
  name                = var.subnets[count.index].name
  address_prefixes    = var.subnets[count.index].address_prefixes
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}
