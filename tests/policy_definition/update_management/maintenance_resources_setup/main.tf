data "azurerm_client_config" "current" {
}

resource "random_pet" "deploy_maintenance_resources" {
  keepers = {
    policy_definition = jsonencode(local.policy_definition)
  }
  length = 1
}

resource "azurerm_policy_definition" "deploy_maintenance_resources" {
  # Mandatory resource attributes
  name         = "${local.policy_definition.name}-${random_pet.deploy_maintenance_resources.id}"
  policy_type  = "Custom"
  mode         = local.policy_definition.properties.mode
  display_name = "local.policy_definition.properties.displayName-${random_pet.deploy_maintenance_resources.id}"

  # Optional resource attributes
  description = try(local.policy_definition.properties.description, "${local.policy_definition.name} Policy Definition deployed for testing")
  policy_rule = try(length(local.policy_definition.properties.policyRule) > 0, false) ? jsonencode(local.policy_definition.properties.policyRule) : null
  metadata    = try(length(local.policy_definition.properties.metadata) > 0, false) ? jsonencode(local.policy_definition.properties.metadata) : null
  parameters  = try(length(local.policy_definition.properties.parameters) > 0, false) ? jsonencode(local.policy_definition.properties.parameters) : null
}

//TODO: Test in different Subscriptions instead of RGs

resource "azurerm_resource_group" "this" {
  name     = "rg-TestUpdateManagementPolicy${random_pet.deploy_maintenance_resources.id}-dev-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "management" {
  name     = "rg-TestUpdateManagementPolicyManagement${random_pet.deploy_maintenance_resources.id}-dev-01"
  location = "westeurope"
  provider = azurerm.management
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-TestUpdateManagementPolicy-dev-01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-TestUpdateManagementPolicy-dev-01"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]
}
