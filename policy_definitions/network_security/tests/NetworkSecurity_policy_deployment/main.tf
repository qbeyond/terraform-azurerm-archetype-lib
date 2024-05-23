
data "azurerm_client_config" "current" {}
module "caf" {
    source = "Azure/caf-enterprise-scale/azurerm"
    version = "5.2.1"
    root_parent_id =  data.azurerm_client_config.current.tenant_id
    default_location = "West Europe"
    providers = {
      azurerm.connectivity = azurerm
      azurerm.management = azurerm
    }
    deploy_core_landing_zones = false
    disable_telemetry = true
    disable_base_module_tags = true

    custom_landing_zones = {
        PolicyTesting = {
            display_name = "PolicyTestingNetworkSecurity"
            parent_management_group_id = data.azurerm_client_config.current.tenant_id
            subscription_ids = [data.azurerm_client_config.current.subscription_id]
            archetype_config = {
                archetype_id = "qby_testNetworkPolicies"
                parameters = {
                }
                access_control = {}
            }
        }
    }
    library_path = "${path.module}/../.."
    root_id = "PolicyTesting"
    template_file_variables = {
        notScopesForQbyNetworkSecurity = []
        
    }
}