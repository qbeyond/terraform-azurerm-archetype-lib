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
  source           = "./../../../../modules/merge_DINE_policy"
  policy_file_path = "./../../policy_definition_qby_deploy_vm_backup.json"
}

locals {
  policy = module.policy_definition_qby_deploy_vm_backup.policy
}

locals {
  policy_set_definition = jsondecode(templatefile("./../../policy_set_definition_vm_backup.json", {root_scope_resource_id = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"}))
}

data "azurerm_client_config" "this" {
}

resource "azurerm_resource_group" "this" {
  name      = var.resource_group_name
  location  = "westeurope"
}

resource "azurerm_policy_set_definition" "this" {
  name = local.policy_set_definition.name
  policy_type = local.policy_set_definition.properties.policyType 
  display_name = local.policy_set_definition.properties.displayName
  
  dynamic "policy_definition_reference" {
    for_each = toset(local.policy_set_definition.properties.policyDefinitions) 
    content {
      policy_definition_id = policy_definition_reference.value.policyDefinitionId
      reference_id = policy_definition_reference.value.policyDefinitionReferenceId
    }
  }
}

resource "azurerm_policy_definition" "this" {
  name         = local.policy.name
  policy_type  = local.policy.properties.policyType
  mode         = local.policy.properties.mode
  display_name = local.policy.properties.displayName

  metadata = jsonencode(local.policy.properties.metadata)


  policy_rule = jsonencode(local.policy.properties.policyRule)


  parameters = jsonencode(local.policy.properties.parameters)
}

module "policy_set_assignment" {
  source  = "qbeyond/policy-set-assignment/azurerm"
  version = "1.0.2"
  scope = azurerm_resource_group.this.id
  location = azurerm_resource_group.this.location
  policy_definitions = [azurerm_policy_definition.this]
  policy_set_definition = azurerm_policy_set_definition.this
}