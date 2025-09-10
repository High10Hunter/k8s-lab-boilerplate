# resource "azurerm_network_security_group" "this" {
#   name                = "${var.vm_name}-nsg"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#
#   security_rule {
#     name                       = "Allow-HTTP"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#
#   security_rule {
#     name                       = "Allow-HTTPS"
#     priority                   = 110
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#
#   security_rule {
#     name                       = "Allow-SSH"
#     priority                   = 120
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }
#
# # Associate NSG with the Network Interface
# resource "azurerm_network_interface_security_group_association" "this" {
#   network_interface_id      = azurerm_network_interface.this.id
#   network_security_group_id = azurerm_network_security_group.this.id
# }
