provider "azurerm" {
  features {
    template_deployment {
      delete_nested_items_during_deletion = false
    }
  }
}

locals {
  policy_path = "../../policy_definition_qby_deploy_virtual_hub_connection"
  policy      = jsondecode(file("${local.policy_path}.json"))
  parameters = {
    virtualHubId                    = module.setup_hub.virtual_hub.id
    hubVirtualNetworkConnectionName = "${azurerm_virtual_network.setup.name}-to-vhub"
    remoteVirtualNetworkId          = azurerm_virtual_network.setup.id
  }
}

module "setup_hub" {
  source = "../setup_hub"
}

resource "azurerm_virtual_network" "setup" {
  name                = "example-network"
  location            = module.setup_hub.resource_group.location
  resource_group_name = module.setup_hub.resource_group.name
  address_space       = ["192.168.1.0/24"]
}

resource "azurerm_resource_group_template_deployment" "exercise" {
  deployment_mode     = local.policy.properties.policyRule.then.details.deployment.properties.mode
  name                = "VirtualHubConnection"
  resource_group_name = module.setup_hub.resource_group.name
  template_content    = file("${local.policy_path}_ARM.json")
  parameters_content = jsonencode({
    for key, parameter_value in local.parameters : key => {
      value = parameter_value
    }
  })
}

module "verify" {
  source          = "../verify"
  virtual_hub     = module.setup_hub.virtual_hub
  virtual_network = azurerm_virtual_network.setup
  depends_on      = [azurerm_resource_group_template_deployment.exercise]
}
