terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

data "azapi_resource" "virtual_hub_connection" {
  name      = "${var.virtual_network.name}-to-vhub"
  parent_id = var.virtual_hub.id
  type      = "Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2022-11-01"

  response_export_values = ["properties.connectivityStatus", "properties.provisioningState", "properties.remoteVirtualNetwork"]

  lifecycle {
    postcondition {
      condition     = jsondecode(self.output).properties.connectivityStatus == "Connected"
      error_message = "The connection status should be connected"
    }
    postcondition {
      condition     = jsondecode(self.output).properties.provisioningState == "Succeeded"
      error_message = "The provisioning status should be connected"
    }
    postcondition {
      condition     = jsondecode(self.output).properties.remoteVirtualNetwork.id == var.virtual_network.id
      error_message = "The provisioning status should be connected"
    }
  }
}
