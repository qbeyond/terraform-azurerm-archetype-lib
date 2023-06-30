
locals {
  resource_group_name = "rg-VmPolicyTest-dev-12" 
}

# call on setup_module 
module "policy_definition_qby_deploy_vm_backup" {
  source           = "../../setup_module"
  resource_group_name = local.resource_group_name
}

# call on setup_vm_module
module "vm_deployment" {
  source           = "../../setup_module_vm"
  resource_group_name = local.resource_group_name
}

resource "azurerm_recovery_services_vault" "name" {
  name = "rsv-PolicySetup-01-westeurope"
  location = "westeurope"
  resource_group_name = local.resource_group_name
  sku = ""
}

# backup policy assignment on recovery service vault (Enhanced Policy)
