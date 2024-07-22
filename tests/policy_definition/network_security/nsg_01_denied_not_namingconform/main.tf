#Expected by Policy Definition to not allow the wrong nsg name
#Expect Deployment to not work
resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecurityNsg-tst-01"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-not-namingconform-name-TestingPolicies"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}