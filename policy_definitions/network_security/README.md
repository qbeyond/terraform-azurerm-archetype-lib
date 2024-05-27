# Restrictions that come with this Set
## Naminconventions that get enforced
//TODO: aus Confluence importieren und als md darstellen

## Inline creation subnet and vnet
Terraform is not able to merge the Subnet with the vnet before checking wether the recources are conform. Therefore the subnet has to be created inline with the vnet, eg. like this:

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

## Deny Rule
The Rule that denys all inbound Traffic is checked based on its Properties.
It checks for:
- direction                   = "Inbound"
- access                      = "Deny"
- protocol                    = "*"
- source_port_range           = "*"
- destination_port_range      = "*"
- source_address_prefix       = "10.0.0.0/16"
- destination_address_prefix  = "10.0.0.0/16"

A fitting Rule could look like this:

    security_rule {   
    name                        = "DenyAllInboundTraffic"
    priority                    = 4096
    direction                   = "Inbound"
    access                      = "Deny"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "10.0.0.0/16"
    destination_address_prefix  = "10.0.0.0/16"
}
