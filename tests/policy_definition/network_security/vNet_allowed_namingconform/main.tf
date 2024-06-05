# Expect Policy Definition to respect correct naming of vNet
# Expect Deployment to work

resource "azurerm_resource_group" "this" {
  name     = "rg-TestingPoliciesNetworkSecurityvNet-tst-01"
  location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-10-0-0-0-16-westeurope"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}
