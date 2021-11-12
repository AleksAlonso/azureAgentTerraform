# Create Virtual Machine

resource "azurerm_public_ip" "modulo7-ado-pip" {
  name                = var.vm_pip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.tamops.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "modulo7-ado-nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.tamops.location
  resource_group_name = azurerm_resource_group.tamops.name

  ip_configuration {
    name                          = "ip"
    subnet_id                     = azurerm_subnet.subnet_name_ado_agent.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm_private_ip_address
    public_ip_address_id          = azurerm_public_ip.modulo7-ado-pip.id
  }
}

resource "azurerm_virtual_machine" "modulo7-ado-vm" {
  name                  = "${var.vm_name}-vm"
  location              = azurerm_resource_group.tamops.location
  resource_group_name   = azurerm_resource_group.tamops.name
  network_interface_ids = [azurerm_network_interface.modulo7-ado-nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = var.vm_osdisk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


  os_profile {
    computer_name  = "${var.vm_name}-vm"
    admin_username = var.vm_username
    admin_password = random_password.password.result
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  # admin_ssh_key {
  #     username       = "modulo7"
  #     public_key     = file("~/.ssh/id_rsa.pub")
  # }

  provisioner "file" {
    source      = "scripts/register.sh"
    destination = "/tmp/register.sh"

    connection {
      type     = "ssh"
      user     = "${var.vm_username}"
      password = random_password.password.result
      host     = azurerm_public_ip.modulo7-ado-pip.ip_address
    }
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/register.sh",
  #     "/tmp/register.sh ${var.ado_token}",
  #   ]

  #   connection {
  #     type     = "ssh"
  #     user     = var.vm_username
  #     password = random_password.password.result
  #     host     = azurerm_public_ip.modulo7-ado-pip.ip_address
  #   }
  # }    
  
}

