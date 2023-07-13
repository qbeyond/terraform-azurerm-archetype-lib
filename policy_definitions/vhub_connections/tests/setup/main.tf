provider "azurerm" {
  features {

  }
}

locals {
  logical_name = "VirtualHubConnection"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-dev-${local.logical_name}-01"
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

module "assign_azure_policy_definition_to_resource_group" {
  count            = var.assign_policy ? 1 : 0
  source           = "./../../../../modules/merge_DINE_policy"
  policy_file_path = "./../../policy_definition_qby_deploy_virtual_hub_connection.json"
  # description = "Path to the policy that is to be tested"
}

resource "azurerm_virtual_network" "this" {
  count               = var.deploy_virtual_network ? 1 : 0
  name                = "vnet-192-168-1-0-24-${azurerm_resource_group.this.location}"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["192.168.1.0/24"]
  location            = azurerm_resource_group.this.location
}
