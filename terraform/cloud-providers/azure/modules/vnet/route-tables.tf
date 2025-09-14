# Private Route Table
resource "azurerm_route_table" "private" {
  count                         = var.create_private_route_table && length(var.private_subnets) > 0 ? 1 : 0
  name                          = var.private_route_table_name != null ? var.private_route_table_name : "${var.vnet_name}-private-rt"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = !var.disable_bgp_route_propagation

  dynamic "route" {
    for_each = var.private_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }

  tags = merge(var.tags, {
    Type = "Private"
  })
}

# Public Route Table
resource "azurerm_route_table" "public" {
  count                         = var.create_public_route_table && length(var.public_subnets) > 0 ? 1 : 0
  name                          = var.public_route_table_name != null ? var.public_route_table_name : "${var.vnet_name}-public-rt"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = !var.disable_bgp_route_propagation

  dynamic "route" {
    for_each = var.public_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }

  tags = merge(var.tags, {
    Type = "Public"
  })
}

# Private Subnet Route Table Associations
resource "azurerm_subnet_route_table_association" "private" {
  count          = var.associate_route_tables && var.create_private_route_table && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = azurerm_subnet.private_subnets[count.index].id
  route_table_id = azurerm_route_table.private[0].id
}

# Public Subnet Route Table Associations
resource "azurerm_subnet_route_table_association" "public" {
  count          = var.associate_route_tables && var.create_public_route_table && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  subnet_id      = azurerm_subnet.public_subnets[count.index].id
  route_table_id = azurerm_route_table.public[0].id
}
