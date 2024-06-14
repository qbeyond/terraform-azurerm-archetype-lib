# Expect Policy Definition to respect correct naming of vNet
# Expect Deployment to not work

resource "azurerm_resource_group" "this" {
  name     = "rg-TestingPoliciesNetworkSecurityvNet-tst-02"
  location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-10-0-0-0-westeurope" # missing size of vNet
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}
