locals {
 rg_name              = "rg-VmPolicyTest-dev-06"
}

module "assign_azure_policy_definition_to_resource_group" {
  source           = "../../modules/az_policy_def_assign"
  rg_name = local.rg_name
}

module "vm_deployment_with_default_backup_tag" {
  source           = "../../modules/vm_deployment_default_backup_tag"
  rg_name = local.rg_name
}