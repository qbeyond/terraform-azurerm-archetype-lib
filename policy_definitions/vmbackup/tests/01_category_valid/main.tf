resource "azurerm_policy_definition" "policy" {
  name         = local.policy.name
  policy_type  = local.policy.properties.policyType
  mode         = local.policy.properties.mode
  display_name = local.policy.properties.displayName

  metadata = jsonencode(local.policy.properties.metadata) 


  policy_rule = jsonencode(local.policy.properties.policyRule)


  parameters = jsonencode(local.policy.properties.parameters.location)
}