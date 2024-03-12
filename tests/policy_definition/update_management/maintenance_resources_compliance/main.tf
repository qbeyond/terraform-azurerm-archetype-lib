resource "azapi_resource_action" "evaluation" {
  type        = "Microsoft.PolicyInsights/policyStates@2019-10-01"
  action      = "triggerEvaluation"
  method      = "POST"
  resource_id = "${var.policy_assignment.subscription_id}/providers/Microsoft.PolicyInsights/policyStates/latest"
}

data "azapi_resource_action" "compliance_state" {
  type                   = "Microsoft.PolicyInsights/policyStates@2019-10-01"
  action                 = "queryResults"
  method                 = "POST"
  resource_id            = "${var.policy_assignment.id}/providers/Microsoft.PolicyInsights/policyStates/latest"
  response_export_values = ["*"]
  depends_on             = [azapi_resource_action.evaluation]
}

