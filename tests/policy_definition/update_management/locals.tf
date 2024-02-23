locals {
  policy_definition_path   = "${path.module}/../../../policy_definitions/update_management/policy_definition_qby_deploy_maintenance_resources.json"
  policy_definition        = jsondecode(file("${local.policy_definition_path}"))
  role_definition_ids      = distinct(flatten([for definition in [local.policy_definition] : definition.properties.policyRule.then.details.roleDefinitionIds]))
  regex_pattern_id_to_name = "[\\w-]+$"

  vm_before_compliance_result = one([for result in jsondecode(data.azapi_resource_action.compliance_state.output).value : result if lower(result.resourceId) == lower(azurerm_windows_virtual_machine.before.id)])
  vm_before_compliance        = local.vm_before_compliance_result == null ? null : local.vm_before_compliance_result.isCompliant
}
