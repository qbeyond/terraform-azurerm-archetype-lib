output "policy_definition" {
  description = "The policy definition that was created."
  value       = azurerm_policy_definition.deploy_maintenance_resources
}

output "resource_group_vm" {
  description = "The resource group that was created for the VMs."
  value       = azurerm_resource_group.this
}

output "resource_group_management" {
  description = "The resource group that was created for the management resources."
  value       = azurerm_resource_group.management
}

output "random_string" {
  description = "The random string to make resource names unique."
  value       = random_pet.deploy_maintenance_resources.id
}

output "subnet" {
  description = "The subnet to deploy the VM to."
  value       = azurerm_subnet.this
}

output "role_definition_ids" {
  description = "The ids of the roledefinitions, that needs to be assigned for the role definition"
  value       = local.role_definition_ids
}
