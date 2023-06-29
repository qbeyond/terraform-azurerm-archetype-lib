locals {
 rg_name              = "rg-VmPolicyTest-dev-04"
}

module "policy_definition_qby_deploy_vm_backup" {
  source              = "../../set_up_module"
  resource_group_name = local.rg_name
}

module "second_module" {
  source              = "../../set_up_module_vm"
  resource_group_name = local.rg_name
}