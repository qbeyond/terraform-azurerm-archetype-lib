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

module "policy_definition_merge" {
  count            = var.assign_policy ? 1 : 0
  source           = "./../../../../modules/merge_DINE_policy"
  policy_file_path = "./../../policy_definition_qby_deploy_virtual_hub_connection.json"
}

locals {
  policy = one(module.policy_definition_merge).policy
}

resource "azurerm_policy_definition" "this" {
  count        = var.assign_policy ? 1 : 0
  name         = local.policy.name
  policy_type  = local.policy.properties.policyType
  mode         = local.policy.properties.mode
  display_name = local.policy.properties.displayName

  metadata = jsonencode(local.policy.properties.metadata)


  policy_rule = jsonencode(local.policy.properties.policyRule)


  parameters = jsonencode(local.policy.properties.parameters)
}

module "policy_assignment" {
  count            = var.assign_policy ? 1 : 0
  source           = "gettek/policy-as-code/azurerm//modules/def_assignment" # use a random module from registry, as this is just a test
  version          = "2.8.2"
  definition       = one(azurerm_policy_definition.this)
  assignment_scope = azurerm_resource_group.this.id
  assignment_parameters = {
    virtualHubId = azurerm_virtual_hub.this.id
  }
}

resource "azurerm_virtual_network" "this" {
  count               = var.deploy_virtual_network ? 1 : 0
  name                = "vnet-192-168-1-0-24-${azurerm_resource_group.this.location}"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["192.168.1.0/24"]
  location            = azurerm_resource_group.this.location
}
