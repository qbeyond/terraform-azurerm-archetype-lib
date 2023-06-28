terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

module "policy_definition_qby_deploy_vm_backup" {
  source           = "./../../../../../modules/merge_DINE_policy"
  policy_file_path = "./../../../policy_definition_qby_deploy_vm_backup.json"
}

locals {
  policy = module.policy_definition_qby_deploy_vm_backup.policy
}

resource "azurerm_policy_definition" "policy" {
  name         = local.policy.name
  policy_type  = local.policy.properties.policyType
  mode         = local.policy.properties.mode
  display_name = local.policy.properties.displayName

  metadata = jsonencode(local.policy.properties.metadata)


  policy_rule = jsonencode(local.policy.properties.policyRule)


  parameters = jsonencode(local.policy.properties.parameters)
}
