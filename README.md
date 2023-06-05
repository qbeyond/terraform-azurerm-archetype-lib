# Introduction 
This repository is our central library of custom policy (set) definitions. Policies defined here will be usable by CAF archetypes in the future.

# Build
This Module merges your archetypelibrary with the one from qbeyond.
Example:

module "archetype-lib" {
  source       = "qbeyond/archetype-lib/azurerm"
  version      = "0.0.1"
  customer_lib = "${path.root}/customer_lib/"
}

output "main_output" {
  value = module.archetype-lib.filenames
}

output "merged_libraries" {
  value = module.archetype-lib.merged_libraries
}
