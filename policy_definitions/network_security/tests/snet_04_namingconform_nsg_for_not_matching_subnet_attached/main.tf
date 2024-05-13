#Expected by Policy Definition to detect, that the nsg name does not match the Vnet name
#Expect Deployment to not work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-04"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-10-0-1-0-24-subscriptionname-TestingPolicies"
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
    source_address_prefix       = "10.0.0.0/24"
    destination_address_prefix  = "10.0.0.0/24"
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
