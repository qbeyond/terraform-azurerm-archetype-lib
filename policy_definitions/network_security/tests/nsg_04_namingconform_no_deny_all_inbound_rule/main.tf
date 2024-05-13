#Expected by Policy Definition to add a rule, that denys all inbound Vnet traffic
#Expect Deployment to work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecurityNsg-tst-04"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-vnet-10-0-0-0-16-subscriptionname-TestingPolicies"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}
