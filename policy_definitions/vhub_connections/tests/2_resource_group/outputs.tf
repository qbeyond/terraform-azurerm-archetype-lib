output "wait_for_policy" {
  value = "az policy state trigger-scan --resource-group ${module.setup_hub.resource_group.name}"
}
