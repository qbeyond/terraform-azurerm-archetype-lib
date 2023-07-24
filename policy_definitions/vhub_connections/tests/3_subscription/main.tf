provider "azurerm" {
  features {
  }
}

data "azurerm_client_config" "current" {
}

module "setup_hub" {
  source = "../setup_hub"
}

module "setup_policy" {
  source         = "../setup_policy"
  virtual_hub_id = module.setup_hub.virtual_hub.id
  scope          = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  random_string  = module.setup_hub.random_string
}

resource "azurerm_resource_group" "this" {
  name     = "rg-dev-VHubConnectionVnet${module.setup_hub.random_string}-01"
  location = "WestEurope"
}

resource "azurerm_virtual_network" "exercise" {
  count               = var.exercise ? 1 : 0
  name                = "vnet-192-168-1-0-24-westeurope"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["192.168.1.0/24"]
}

module "verify" {
  source          = "../verify"
  count           = var.exercise ? 1 : 0
  virtual_hub     = module.setup_hub.virtual_hub
  virtual_network = one(azurerm_virtual_network.exercise)
}
