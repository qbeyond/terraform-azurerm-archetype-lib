terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  resource_group_name = var.resource_group_name
  location            = "westeurope"
}

resource "azurerm_virtual_network" "this" {
  name                = "vm-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

}

resource "azurerm_subnet" "this" {
  name                 = "vm-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_interface" "this" {
  name                = "vm-network-interface"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "vm-ip-configuration"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "this" {
  name                  = var.vm_name # naming convention vm-CAPS01
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.this.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "test-vm"
    admin_username = "adminuser"
    admin_password = "Hamburg2021!"
  }

  tags = {
    "backup" = "QbyDefault"
  }
}