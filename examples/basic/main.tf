module "archetype_lib" {
  source       = "qbeyond/archetype-lib/azurerm"
  customer_lib = "${path.root}/example_lib"
}

output "file_names" {
  value = module.archetype_lib.file_names
}

output "merged_library" {
  value = module.archetype_lib.merged_library
}

