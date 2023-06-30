
locals {
  rg_name = "rg-VmPolicyTest-dev-12" 
}

# call on az_policy_def_assign 
module "assign_azure_policy_definition_to_resource_group" {
  source           = "../../modules/az_policy_def_assign"
  rg_name = local.rg_name
}

# call on setup_vm_module
module "vm_deployment_with_default_backup_tag" {
  source           = "../../modules/vm_deployment_default_backup_tag"
  rg_name = local.rg_name
}

resource "azurerm_recovery_services_vault" "name" {
  name = "rsv-PolicySetup-01-westeurope"
  location = "westeurope"
  rg_name = local.rg_name
  sku = "Standard"
}

# backup policy assignment on recovery service vault (Enhanced Policy)
