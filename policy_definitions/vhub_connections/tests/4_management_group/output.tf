output "wait_for_policy" {
  value = "az policy state trigger-scan --resource-group ${azurerm_resource_group.this.name}"
}
