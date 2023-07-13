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
