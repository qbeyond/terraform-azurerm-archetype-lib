resource "azurerm_network_interface" "virtual_machine_before" {
  name                = "nic-UpdatePolicyTest-${random_pet.deploy_maintenance_resources.id}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "before" {
  name                = "vm-UpdatePolicyTest-${random_pet.deploy_maintenance_resources.id}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  computer_name       = "CUSTAPP001"
  network_interface_ids = [
    azurerm_network_interface.virtual_machine_before.id,
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
    "Severity Group Monthly" = "01-first-monday-2000-csu-reboot"
    "Update Allowed"         = "Yes"
  }
}
