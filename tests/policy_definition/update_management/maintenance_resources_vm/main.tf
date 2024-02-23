resource "azurerm_network_interface" "this" {
  name                = "nic-UpdatePolicyTest-${var.random_string}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "this" {
  name                = "vm-UpdatePolicyTest-${var.random_string}"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  computer_name       = "CUSTAPP001"
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  tags = {
    "Severity Group Monthly" = var.severity_group
    "Update Allowed"         = "Yes"
  }
}
