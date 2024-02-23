data "azurerm_client_config" "current" {
}

resource "azurerm_subscription_policy_assignment" "this" {
  name                 = var.policy_definition.name
  subscription_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  location             = var.resource_group.location
  policy_definition_id = var.policy_definition.id
  description          = var.policy_definition.description
  display_name         = var.policy_definition.display_name
  parameters = jsonencode({
    "managementSubscriptionId" = {
      "value" = data.azurerm_client_config.current.subscription_id
    }
    "managementResourceGroup" = {
      "value" = var.resource_group.name
    }
    "location" = {
      "value" = var.resource_group.location
    }
  })
  identity {
    type = "SystemAssigned"
  }
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
  principal_id       = azurerm_subscription_policy_assignment.this.identity[0].principal_id
}
