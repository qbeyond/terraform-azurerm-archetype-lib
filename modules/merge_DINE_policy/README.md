# Merge Deploy if Not Exist Policy

This module merges the ARM template and rest of a deploy if not exist policy. 

## Usage

You just need to specify the Policy JSON file. The module will look for a file ending in `_ARM.json` with the same name.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policy_file_path"></a> [policy\_file\_path](#input\_policy\_file\_path) | The path to the policy JSON containing everything except the ARM-template. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy"></a> [policy](#output\_policy) | The merged policy JSON with the ARM template as terraform object. |
## Resource types

No resources.


## Modules

No modules.
## Resources by Files

No resources.

<!-- END_TF_DOCS -->