#Expected by Policy Definition to ignore this nsg
#Expect Deployment to work
resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecurityNsg-tst-01"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-not-namingconform-name-TestingPolicies"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}

data "azurerm_client_config" "current" {}
module "caf" {
    source = "Azure/caf-enterprise-scale/azurerm"
    version = "5.2.1"
    root_parent_id =  data.azurerm_client_config.current.tenant_id
    default_location = azurerm_resource_group.this.location
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
                parameters = {}
                access_control = {}
            }
        }
    }
    library_path = "${path.module}/../.."
    root_id = "PolicyTesting"
}