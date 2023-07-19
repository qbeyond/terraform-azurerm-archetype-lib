output "resource_group" {
  description = "The created resource group."
  value       = azurerm_resource_group.this
}

output "virtual_hub" {
  description = "The created virtual hub."
  value       = azurerm_virtual_hub.this
}

output "random_string" {
  description = "The random string used to build names of resources. Can be used to have coherent naming."
  value       = local.random_string
}
