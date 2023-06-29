# Archetype Library
[![GitHub tag](https://img.shields.io/github/tag/qbeyond/terraform-azurerm-archetype-lib.svg)](https://registry.terraform.io/modules/qbeyond/terraform-azurerm-archetype-lib/provider/latest)
[![License](https://img.shields.io/github/license/qbeyond/terraform-azurerm-archetype-lib.svg)](https://github.com/qbeyond/terraform-azurerm-archetype-lib/blob/main/LICENSE)

----

This [repository](https://github.com/qbeyond/terraform-azurerm-archetype-lib) is our central library of custom policy (set) definitions. Policies defined here will be usable by CAF archetypes.
Via this Module, named [archetype-lib](https://registry.terraform.io/modules/qbeyond/archetype-lib/azurerm/latest), all q.beyond archetype-, policy-, policy set- and role definitions and policy assignments will be summarized in one folder with all the azurerm compatible definitions and assignments.
That folder will contain the external and the q.beyond definitions and assignments. The planned use case is to hand the output `merged_library` of this Module to the CAF-Module, as it can only handle one Folder as input containing definitions and assignments.

## Repository Structure

<!--- TODO: Explain archetypes somewhere (eg. README in Subfolder or this) -->

- `archetypes` contains archetype definitions without subfolders, the name serves as description
  - archetypes definitions may use custom `policy_definitions` and `role_definitions`
- `examples` contains one example per subfolder (See [Examples](#examples))
- `modules` contains terraform modules shared by multiple tests or used by the `archetype` module itself
- `policy_definitions` contains custom policy definitions separated in subfolders
  - Each subfolder contains a `tests` folder containing tests in subfolders based on the four phase model *Setup*, *Exercise*, *Verify*, *Cleanup* with a `README.md` describing the purpose and each phase of the test
  - policy assignment templates are named `policy_assignment_<custom_name>.tmpl.json`
  - policy definitions are named `policy_definition_<custom_name>.json`
  - If the policy uses an ARM-template (eg. DeployIfNotExist policies) it is separated into a file `policy_definition_<custom_name>_ARM.json`
  - policy set definitions are named `policy_set_definition_<custom_name>.json`
- `role_definitions` contains custom role definitions
- `*.tf` files that make up the archetype-lib module

<!-- BEGIN_TF_DOCS -->

## Examples

### Basic
First, the given template is adding this Module as `archetype_lib`. The Path of the library that is supposed to be summarized with the q.beyond library is set as the value of `cutomer_lib`.
The output ´file_names´ can be used to manualy check whether all files that are supposed to be included in the merged library are included, as it outputs the names of all files that were added.
The output of `merged_library` is supposed to be the input for the [CAF-Module](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) for the parameter named `archetype_lib`

```hcl
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

| Name                                                          | Version |
| ------------------------------------------------------------- | ------- |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~>2.4.0 |

## Inputs

| Name                                                                     | Description                                                                                                                                                                                                   | Type     | Default | Required |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_customer_lib"></a> [customer\_lib](#input\_customer\_lib) | Path to the customer libary folder containing definition files that are supposed to be used by the CAF-Module. This module picks all CAF compatible definitions from the given folder and its subdirectories. | `string` | n/a     |   yes    |
## Outputs

| Name                                                                             | Description                                                                                                   |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| <a name="output_file_names"></a> [file\_names](#output\_file\_names)             | Outputs the files which were added to the library.                                                            |
| <a name="output_merged_library"></a> [merged\_library](#output\_merged\_library) | Path to where the library containing both libraries can be found. This output can be given to the CAF-Module. |

## Resource types
| Type                                                                                             | Used |
| ------------------------------------------------------------------------------------------------ | ---- |
| [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | 1    |
**`Used` only includes resource blocks.** `for_each` and `count` meta arguments, as well as resource blocks of modules are not considered.

## Modules

No modules.

## Resources by Files
### /terraform-docs/main.tf
| Name                                                                                                          | Type     |
| ------------------------------------------------------------------------------------------------------------- | -------- |
| [local_file.copied_files](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
<!-- END_TF_DOCS -->
