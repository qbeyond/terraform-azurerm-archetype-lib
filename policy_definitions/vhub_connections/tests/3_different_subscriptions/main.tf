provider "azurerm" {
  alias           = "hub"
  subscription_id = var.subscription_id_hub
  features {
  }
}

provider "azurerm" {
  alias = "vnet"
  features {
  }
}

data "azurerm_client_config" "current" {
  lifecycle {
    postcondition {
      condition     = var.subscription_id_hub != self.subscription_id
      error_message = "The current subscription should not be the subscription of the virtual hub. Switch to another subscription."
    }
  }
}

module "setup_hub" {
  source = "../setup_hub"
  providers = {
    azurerm = azurerm.hub
  }
  depends_on = [data.azurerm_client_config.current]
}


module "setup_policy" {
  source = "../setup_policy"
  providers = {
    "azurerm" = azurerm.vnet
  }
  virtual_hub_id = module.setup_hub.virtual_hub.id
  scope          = "/subscriptions/${azurerm_client_config.current.subscription_id}"
}

resource "random_pet" "this" {
  length = 1
}

resource "azurerm_resource_group" "this" {
  name     = "rg-dev-VHubConnection${random_pet.this.id}-01"
  location = "WestEurope"
}

resource "azurerm_virtual_network" "setup" {
  count               = var.exercise ? 1 : 0
  name                = "vnet-192-168-1-0-24-westeurope"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["192.168.1.0/24"]
}
