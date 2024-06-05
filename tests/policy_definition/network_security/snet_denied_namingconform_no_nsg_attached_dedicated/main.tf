#Expected by Policy Definition to detect, that no nsg is attached to the subnet
#Expect Deployment to not work

resource "azurerm_resource_group" "this" {
  name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-12"
  location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-10-0-0-0-16-westeurope"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azapi_resource" "subnet" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2023-11-01"
  name      = "nope"
  parent_id = azurerm_virtual_network.this.id
  body = jsonencode({
    properties = {
      addressPrefix = "10.0.1.0/24"
    }
  })
}
