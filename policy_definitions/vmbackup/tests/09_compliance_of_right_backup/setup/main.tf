module "vm_deployment_with_default_backup_tag" {
  source           = "../../modules/vm_deployment_default_backup_tag"
  rg_name = "rg-VmPolicyTest-dev-09"
}