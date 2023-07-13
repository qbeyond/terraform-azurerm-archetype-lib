output "resource_group" {
  description = "The created resource group."
  value       = azurerm_resource_group.this
}

output "virtual_hub" {
  description = "The created virtual hub."
  value       = azurerm_virtual_hub.this
}
