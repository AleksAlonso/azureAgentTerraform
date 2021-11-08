resource "azurerm_network_security_group" "modulo7-ado-nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.tamops.location
  resource_group_name = azurerm_resource_group.tamops.name
}

# resource "azurerm_network_security_rule" "outbound" {
#   name                        = "ssh-allow"
#   priority                    = 100
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.tamops.name
#   network_security_group_name = azurerm_network_security_group.modulo7-ado-nsg.name
# }

resource "azurerm_network_security_rule" "inbound" {
  name                        = "ssh-allow"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tamops.name
  network_security_group_name = azurerm_network_security_group.modulo7-ado-nsg.name
}

resource "azurerm_network_interface_security_group_association" "modulo7-ado-nic-nsg" {
  network_interface_id      = azurerm_network_interface.modulo7-ado-nic.id
  network_security_group_id = azurerm_network_security_group.modulo7-ado-nsg.id
}