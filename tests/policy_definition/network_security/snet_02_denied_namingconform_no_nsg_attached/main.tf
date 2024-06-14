#Expected by Policy Definition to detect, that no nsg is attached to the subnet
#Expect Deployment to not work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-02"
    location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
    name                = "vnet-10-0-0-0-16-westeurope"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
      subnet {
    name           = "snet-10-0-1-0-24-TestingPolicies1"
    address_prefix = "10.0.1.0/24"
  }
}