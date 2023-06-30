locals {
 rg_name              = "rg-VmPolicyTest-dev-10"
}

module "policy_definition_qby_deploy_vm_backup" {
  source              = "../../setup_module"
  resource_group_name = local.rg_name
}

module "second_module" {
  source              = "../../setup_module_vm"
  resource_group_name = local.rg_name
}