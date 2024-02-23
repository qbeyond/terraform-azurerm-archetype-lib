locals {
  policy_definition_path = "${path.module}/../../../../policy_definitions/update_management/policy_definition_qby_deploy_maintenance_resources.json"
  policy_definition      = jsondecode(file("${local.policy_definition_path}"))
  role_definition_ids    = distinct(flatten([for definition in [local.policy_definition] : definition.properties.policyRule.then.details.roleDefinitionIds]))
}
