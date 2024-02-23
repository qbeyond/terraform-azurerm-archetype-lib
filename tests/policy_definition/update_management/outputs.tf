output "compliance_vm_before" {
  description = "The compliance of the Vm deployed before the policy was assigned. Should be non compliant."
  value       = one([for result in jsondecode(data.azapi_resource_action.compliance_state.output).value : result if lower(result.resourceId) == lower(azurerm_windows_virtual_machine.before.id)]).isCompliant
}

output "evaluation_trigger_command" {
  description = "Command to trigger a policy evaluation on the resource group manually. This is automatically done on changes of the policy or VM."
  value       = "az policy state trigger-scan --resource-group ${azurerm_resource_group.this.name}"
}
