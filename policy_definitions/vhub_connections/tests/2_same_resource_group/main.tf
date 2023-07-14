provider "azurerm" {
  features {
  }
}

module "setup_hub" {
  source = "../setup_hub"
}

module "setup_policy" {
  source         = "../setup_policy"
  virtual_hub_id = module.setup_hub.virtual_hub.id
  scope          = module.setup_hub.resource_group.id
}

resource "azurerm_virtual_network" "exercise" {
  count               = var.exercise ? 1 : 0
  name                = "vnet-192-168-1-0-24-westeurope"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["192.168.1.0/24"]
}

