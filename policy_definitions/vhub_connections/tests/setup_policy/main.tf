module "policy_definition_merge" {
  source           = "./../../../../modules/merge_DINE_policy"
  policy_file_path = "./../../policy_definition_qby_deploy_virtual_hub_connection.json"
}

locals {
  policy = module.policy_definition_merge.policy
}

resource "random_pet" "this" {
  length = 1
}

resource "azurerm_policy_definition" "this" {
  count        = var.assign_policy ? 1 : 0
  name         = "${local.policy.name}${random_pet.this.id}"
  policy_type  = local.policy.properties.policyType
  mode         = local.policy.properties.mode
  display_name = local.policy.properties.displayName

  metadata = jsonencode(local.policy.properties.metadata)

  policy_rule = jsonencode(local.policy.properties.policyRule)

  parameters = jsonencode(local.policy.properties.parameters)
}

module "policy_assignment" {
  count            = var.assign_policy ? 1 : 0
  source           = "gettek/policy-as-code/azurerm//modules/def_assignment" # use a random module from registry, as this is just a test
  version          = "2.8.2"
  definition       = azurerm_policy_definition.this
  assignment_scope = var.scope
  assignment_parameters = {
    virtualHubId = var.virtual_hub_id
  }
}
