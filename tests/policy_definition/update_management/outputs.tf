output "compliance_vm_before" {
  description = "The compliance of the Vm deployed before the policy was assigned. Should be non compliant."
  value       = local.vm_before_compliance
}

output "evaluation_trigger_command" {
  description = "Command to trigger a policy evaluation on the resource group manually. This is automatically done on changes of the policy or VM."
  value       = "az policy state trigger-scan --resource-group ${azurerm_resource_group.this.name}"
}
