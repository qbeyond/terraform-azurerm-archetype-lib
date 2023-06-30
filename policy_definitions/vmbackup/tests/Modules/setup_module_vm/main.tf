terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  skip_provider_registration = true
}

locals {
  vm_name = var.vm_name 
  rg_name = var.resource_group_name 
}

resource "azurerm_resource_group" "vm_module" {
  name      = local.rg_name
  location  = "westeurope"
}

resource "azurerm_virtual_network" "vm_module" {
  name = "vnet-10-0-0-0-6-westeurope"
  location = "westeurope"
  resource_group_name = local.rg_name
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vm_module" {
  name = "internal"
  address_prefixes = ["10.0.2.0/16"]
  resource_group_name = local.rg_name
  virtual_network_name = azurerm_virtual_network.vm_module.name
  
}

resource "azurerm_network_interface" "vm_module" {
  name = "${local.vm_name}-nic"
  location = "westeurope"
  resource_group_name = local.rg_name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.vm_module.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm_module" {
  name = local.vm_name # naming convention vm-CAPS01
  resource_group_name = local.rg_name
  location = "westeurope" 
  network_interface_ids = [azurerm_network_interface.vm_module.id]
  vm_size = "Standard_B1s"

  storage_os_disk {
    name = "${local.vm_name}-osdisk"
    managed_disk_type = "Standard_LRS"
    create_option = "Empty"
  }

  os_profile_linux_config {
    disable_password_authentication = true
  }
  
  tags = {
    Backup = "QbyDefault"
  }
}

