#Expected by Policy Definition to acknowlege the rule, that denys all inbound Vnet traffic
#Expect Deployment to work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecurityNsg-tst-02"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-vnet-10-0-0-0-16-subscriptionname-TestingPolicies"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    security_rule {   
        name                        = "DenyAllTraffic"
        priority                    = 4096
        direction                   = "Inbound"
        access                      = "Deny"
        protocol                    = "*"
        source_port_range           = "*"
        destination_port_range      = "*"
        source_address_prefix       = "10.0.0.0/16"
        destination_address_prefix  = "10.0.0.0/16"
    }
}
