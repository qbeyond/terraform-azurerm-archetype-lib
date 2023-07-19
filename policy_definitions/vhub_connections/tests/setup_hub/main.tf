terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

locals {
  logical_name  = "VirtualHubConnection"
  random_string = var.random_string == null ? random_pet.this.id : var.random_string
}

resource "random_pet" "this" {
  length = 1
}

resource "azurerm_resource_group" "this" {
  name     = "rg-dev-${local.logical_name}${local.random_string}-01"
  location = "WestEurope"
}

resource "azurerm_virtual_wan" "this" {
  name                = "vwan-${local.logical_name}-${azurerm_resource_group.this.location}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_virtual_hub" "this" {
  name                = "vwan-10-0-1-0-24-${azurerm_resource_group.this.location}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  virtual_wan_id      = azurerm_virtual_wan.this.id
  address_prefix      = "10.0.1.0/24"
}
