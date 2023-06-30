module "vm_deployment_with_default_backup_tag" {
  source           = "../../modules/vm_deployment_default_backup_tag"
  rg_name = "rg-VmPolicyTest-dev-08"
}

# "and no BackUp enabled"
# when creating a vm as in `vm_deployment_with_default_backup_tag``the back is via default disabled
# "problem" could be, that if an policy is active, that automaicly enables backups this requirement is not able to be produced