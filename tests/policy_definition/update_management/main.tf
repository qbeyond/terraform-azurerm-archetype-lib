provider "azurerm" {
  features {}
}

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
  display_name = local.policy_definition.properties.displayName

  # Optional resource attributes
  description = try(local.policy_definition.properties.description, "${local.policy_definition.name} Policy Definition deployed for testing")
  policy_rule = try(length(local.policy_definition.properties.policyRule) > 0, false) ? jsonencode(local.policy_definition.properties.policyRule) : null
  metadata    = try(length(local.policy_definition.properties.metadata) > 0, false) ? jsonencode(local.policy_definition.properties.metadata) : null
  parameters  = try(length(local.policy_definition.properties.parameters) > 0, false) ? jsonencode(local.policy_definition.properties.parameters) : null
  lifecycle {
    create_before_destroy = true
  }
}

//TODO: Test in different Subscriptions instead of RGs

resource "azurerm_resource_group" "this" {
  name     = "rg-TestUpdateManagementPolicy${random_pet.deploy_maintenance_resources.id}-dev-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "management" {
  name     = "rg-TestUpdateManagementPolicyManagement-dev-01"
  location = "westeurope"
}

resource "azurerm_subscription_policy_assignment" "deploy_maintenance_resources" {
  name                 = azurerm_policy_definition.deploy_maintenance_resources.name
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  location             = azurerm_resource_group.this.location
  policy_definition_id = azurerm_policy_definition.deploy_maintenance_resources.id
  description          = azurerm_policy_definition.deploy_maintenance_resources.description
  display_name         = azurerm_policy_definition.deploy_maintenance_resources.display_name
  parameters = jsonencode({
    "managementSubscriptionId" = {
      "value" = data.azurerm_client_config.current.subscription_id
    }
    "managementResourceGroup" = {
      "value" = azurerm_resource_group.management.name
    }
    "location" = {
      "value" = azurerm_resource_group.management.location
    }
  })
  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [azurerm_windows_virtual_machine.before]
}

# Data source is needed, to generate role id for specific scope, to avoid changes outside of terraform
data "azurerm_role_definition" "this" {
  for_each           = toset(local.role_definition_ids)
  role_definition_id = regex(local.regex_pattern_id_to_name, each.key)
  scope              = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
}

resource "azurerm_role_assignment" "this" {
  for_each           = data.azurerm_role_definition.this
  scope              = each.value.scope
  role_definition_id = each.value.id
  principal_id       = azurerm_subscription_policy_assignment.deploy_maintenance_resources.identity[0].principal_id
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

resource "azapi_resource_action" "evaluation" {
  type        = "Microsoft.PolicyInsights/policyStates@2019-10-01"
  action      = "triggerEvaluation"
  method      = "POST"
  resource_id = "${azurerm_resource_group.this.id}/providers/Microsoft.PolicyInsights/policyStates/latest"
  depends_on  = [azurerm_subscription_policy_assignment.deploy_maintenance_resources, azurerm_windows_virtual_machine.before]
  lifecycle {
    replace_triggered_by = [azurerm_policy_definition.deploy_maintenance_resources]
  }
}
