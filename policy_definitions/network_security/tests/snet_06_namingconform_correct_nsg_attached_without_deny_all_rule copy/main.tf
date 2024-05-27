#Expect Policy Definition to acknowlede, that subnet is named correctly and nsg is attached, but the nsg has no deny all rule.
#Expect to block the NSG creation and with that the vnet and subnets because it needs to be created first in order to attach it to the subnet by terraform
#Expect Deployment to not work

resource "azurerm_resource_group" "this" {
    name     = "rg-TestingPoliciesNetworkSecuritySnet-tst-06"
    location = "West Europe"
}

resource "azurerm_network_security_group" "this" {
    name                = "nsg-vnet-10-0-0-0-16-westeurope"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
        security_rule {   
        name                        = "AllowAllTraffic"
        priority                    = 4096
        direction                   = "Inbound"
        access                      = "Allow"
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
    security_group = azurerm_network_security_group.this.id
  }
    subnet {
    name           = "snet-10-0-2-0-24-TestingPolicies2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.this.id
  }
}
