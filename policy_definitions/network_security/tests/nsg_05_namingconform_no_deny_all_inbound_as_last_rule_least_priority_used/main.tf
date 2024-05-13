#Expect the Policy Definition to detect, that there is no rule, that denies all inbound Vnet traffic and the least priority Rule is used
#Expect Deployment to fail

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecurityNsg-tst-05"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-10-0-1-0-16-subscriptionname-TestingPolicies"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "this" {
    name                        = "TestRuleToBlockleastPriorityRuleUsed"
    priority                    = 4096
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "10.0.0.0/16"
    destination_address_prefix  = "10.0.0.0/16"
    resource_group_name         = azurerm_network_security_group.this.resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}