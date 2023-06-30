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
}

resource "azurerm_resource_group" "this" {
  name      = var.resource_group_name
  location  = "westeurope"
}

resource "azurerm_virtual_network" "name" {
  name = ""
  location = "westeurope"
  resource_group_name = var.resource_group_name
  address_space = ["10.0.0.0/16"]

   subnet {
    name = ""
    address_prefix = ""
  }
}

resource "azurerm_network_interface" "name" {
  name = ""
  location = "westeurope"
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name = ""
    subnet_id = ""
    private_ip_address_allocation = ""
  }
}

resource "azurerm_virtual_machine" "name" {
  name = var.vm_name # naming convention vm-CAPS01
  resource_group_name = var.resource_group_name #get from other module
  location = "westeurope" 
  network_interface_ids = azurerm_network_interface.id
  vm_size = "Standard_B1s"

  storage_os_disk {
    name = ""
    managed_disk_type = ""
  }

  
  tags = {
    Backup = "QbyDefault"
  }
}

