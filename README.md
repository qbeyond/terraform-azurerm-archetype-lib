<!-- BEGIN_TF_DOCS -->
## Usage

# Introduction
This repository is our central library of custom policy (set) definitions. Policies defined here will be usable by CAF archetypes in the future.

## Examples

### Basic

This is a basic template to use
```hcl
#this is the module needed to join both 
module "archetype_lib" {
  source       = "qbeyond/archetype-lib/azurerm"
  version      = "0.0.1"
  customer_lib = "${path.root}/example_lib"
}

output "file_names" {
  value = module.archetype_lib.file_names
}

output "merged_librarie" {
  value = module.archetype_lib.merged_librarie
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_local"></a> [local](#requirement\_local) | ~>2.4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_lib"></a> [customer\_lib](#input\_customer\_lib) | Path to the customer libaray folder containing definition files that are supposed to be used by the CAF-Module. This module picks all CAF compatible definitions from the given folder and its subdirectories. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_names"></a> [file\_names](#output\_file\_names) | Outputs the files wich were added to the library |
| <a name="output_merged_library"></a> [merged\_library](#output\_merged\_library) | Path to where the library, containing both libraries can be found. This output can be given to the CAF-Module. |

## Resource types
| Type | Used |
|------|-------|
| [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | 1 |
**`Used` only includes resource blocks.** `for_each` and `count` meta arguments, as well as resource blocks of modules are not considered.

## Modules

No modules.

## Resources by Files
### main.tf
| Name | Type |
|------|------|
| [local_file.copied_files](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
<!-- END_TF_DOCS -->