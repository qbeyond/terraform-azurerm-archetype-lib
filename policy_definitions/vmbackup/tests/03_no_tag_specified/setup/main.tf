module "assign_azure_policy_definition_to_resource_group" {
  source           = "../../modules/az_policy_def_assign"
  rg_name = "rg-VmPolicyTest-dev-03" 
}