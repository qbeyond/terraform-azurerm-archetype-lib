#this is the module needed to join both 
module "archetype_lib" {
  source       = "qbeyond/archetype-lib/azurerm"
  version      = "0.0.1"
  customer_lib = "${path.root}/example_lib"
}

output "file_names" {
  value = module.archetype_lib.file_names
}

output "merged_libraries" {
  value = module.archetype_lib.merged_libraries
}
