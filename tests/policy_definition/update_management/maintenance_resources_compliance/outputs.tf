output "resource_compliance" {
  description = "Map of resourceId to query result"
  value       = { for result in jsondecode(data.azapi_resource_action.compliance_state.output).value : lower(result.resourceId) => result }
}
