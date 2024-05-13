#Expect Policy Definition to acknowlede, that subnet is named correctly and correct nsg is attached
#Expect Deployment to work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-01"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-10-0-1-0-16-subscriptionname-TestingPolicies"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "this" {
    name                        = "DenyAllTraffic"
    priority                    = 4096
    direction                   = "Inbound"
    access                      = "Deny"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "10.0.0.0/16"
    destination_address_prefix  = "10.0.0.0/16"
    resource_group_name         = azurerm_network_security_group.this.resource_group_name
    network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_virtual_network" "this" {
    name                = "vnet-10-0-0-0-16-westeurope"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "snet_10_0_1_0_24" {
    name                 = "snet-10-0-1-0-24-TestingPolicies"
    resource_group_name  = azurerm_resource_group.this.name
    virtual_network_name = azurerm_virtual_network.this.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "example" {
    subnet_id                 = azurerm_subnet.snet_10_0_1_0_24.id
    network_security_group_id = azurerm_network_security_group.this.id
}
