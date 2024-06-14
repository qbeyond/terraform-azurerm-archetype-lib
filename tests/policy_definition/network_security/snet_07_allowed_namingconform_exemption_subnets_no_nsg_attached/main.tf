#Expect Policy Definition to acknowlede, that subnet is named correctly and that no nsg is necessary, because they have the names of the expemtions
#Expect Deployment to work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-07"
    location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
    name                = "vnet-10-0-0-0-16-westeurope"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name

  subnet {
    name           = "AzureFirewallSubnet"
    address_prefix = "10.0.1.0/24"
  }
    subnet {
    name           = "RouteServerSubnet"
    address_prefix = "10.0.2.0/24"
  }
      subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.0.3.0/24"
  }
      subnet {
    name           = "AzureBastionSubnet"
    address_prefix = "10.0.4.0/24"
  }
}
