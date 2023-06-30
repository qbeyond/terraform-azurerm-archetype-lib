locals {
 rg_name           = "rg-VmPolicyTest-dev-04"
 vm_name = "vm-TEST04"
 rsv_name = "rsv-PolicySetup-04-westeurope"
}

module "assign_az_policy_def_to_rg" {
  source           = "../../modules/az_policy_def_assign"
  rg_name = local.rg_name
}

module "vm_deployment_with_default_backup_tag" {
  source           = "../../modules/vm_deployment_default_backup_tag"
  rg_name = local.rg_name
  vm_name = local.vm_name
}



output "virtual_machine_id" {
  value = module.vm_deployment_with_default_backup_tag.virtual_machine_id
  #depends_on = [vm_deployment_with_default_backup_tag]
}

module "assign_backup_policy_to_vm"{
  source = "../../modules/setup_backup_policy_assign"
  rg_name = local.rg_name
  vm_id = data.virtual_machine_id.value
  rsv_name = local.rsv_name

}