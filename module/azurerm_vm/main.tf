resource "azurerm_network_interface" "nic" {
  name                = var.azurerm_network_interface
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = var.azurerm_linux_virtual_machine
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.user_name
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]
  disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}