#Expect Policy Definition to acknowlede, that subnet is named correctly and correct nsg is attached
#Expect Deployment to work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-01"
    location = "West Europe"
}

resource "azurerm_network_security_group" "one" {
    name                = "nsg-snet-10-0-1-0-24-TestingPolicies1"
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

resource "azurerm_network_security_group" "two" {
    name                = "nsg-snet-10-0-2-0-24-TestingPolicies2"
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
resource "azurerm_virtual_network" "this" {
    name                = "vnet-10-0-0-0-16-westeurope"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name

  subnet {
    name           = "snet-10-0-1-0-24-TestingPolicies1"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.one.id
  }
    subnet {
    name           = "snet-10-0-2-0-24-TestingPolicies2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.two.id
  }
}
