

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

locals {
  policy_definition_path   = "${path.module}/../../../policy_definitions/update_management/policy_definition_qby_deploy_maintenance_resources.json"
  policy_definition        = jsondecode(file("${local.policy_definition_path}"))
  role_definition_ids      = distinct(flatten([for definition in [local.policy_definition] : definition.properties.policyRule.then.details.roleDefinitionIds]))
  regex_pattern_id_to_name = "[\\w-]+$"
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

resource "azurerm_resource_group_policy_assignment" "deploy_maintenance_resources" {
  name                 = azurerm_policy_definition.deploy_maintenance_resources.name
  location             = azurerm_resource_group.this.location
  resource_group_id    = azurerm_resource_group.this.id
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
  scope              = azurerm_resource_group.this.id
}

resource "azurerm_role_assignment" "this" {
  for_each           = data.azurerm_role_definition.this
  scope              = azurerm_resource_group.this.id
  role_definition_id = each.value.id
  principal_id       = azurerm_resource_group_policy_assignment.deploy_maintenance_resources.identity[0].principal_id
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
  depends_on  = [azurerm_resource_group_policy_assignment.deploy_maintenance_resources, azurerm_windows_virtual_machine.before]
  lifecycle {
    replace_triggered_by = [azurerm_policy_definition.deploy_maintenance_resources]
  }
}

data "azapi_resource_action" "compliance_state" {
  type                   = "Microsoft.PolicyInsights/policyStates@2019-10-01"
  action                 = "queryResults"
  method                 = "POST"
  resource_id            = "${azurerm_resource_group_policy_assignment.deploy_maintenance_resources.id}/providers/Microsoft.PolicyInsights/policyStates/latest"
  response_export_values = ["*"]
  depends_on             = [azapi_resource_action.evaluation]
  lifecycle {
    postcondition {
      condition     = one([for result in jsondecode(self.output).value : result if lower(result.resourceId) == lower(azurerm_windows_virtual_machine.before.id)]).isCompliant == false
      error_message = "The vm deployed before should be noncompliant, because it already existed before the policy and therefore the resource weren't deployed."
    }
  }
}

output "evaluation_trigger_command" {
  description = "Command to trigger a policy evaluation on the resource group manually. This is automatically done on changes of the policy or VM."
  value       = "az policy state trigger-scan --resource-group ${azurerm_resource_group.this.name}"
}
