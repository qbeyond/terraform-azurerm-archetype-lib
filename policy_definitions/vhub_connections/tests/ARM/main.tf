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
    virtualHubId                    = module.setup.virtual_hub.id
    hubVirtualNetworkConnectionName = "${module.setup.virtual_network.name}-to-vhub"
    remoteVirtualNetworkId          = module.setup.virtual_network.id
  }
}

module "setup" {
  source                 = "../setup"
  deploy_virtual_network = true
  assign_policy          = false
}

resource "azurerm_resource_group_template_deployment" "exercise" {
  deployment_mode     = local.policy.properties.policyRule.then.details.deployment.properties.mode
  name                = "VirtualHubConnection"
  resource_group_name = module.setup.resource_group.name
  template_content    = file("${local.policy_path}_ARM.json")
  parameters_content = jsonencode({
    for key, parameter_value in local.parameters : key => {
      value = parameter_value
    }
  })
}
