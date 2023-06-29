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

resource "azurerm_virtual_machine" "name" {
  name = var.vm_name
  resource_group_name = var.resource_group_name #get from other module
  location = "westeurope" 
  #network_interface_ids = 
  #vm_size = 
  
  
  tags = {
    Backup = "QbyDefault"
  }
}