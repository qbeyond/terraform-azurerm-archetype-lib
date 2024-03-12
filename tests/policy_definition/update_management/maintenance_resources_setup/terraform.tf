terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.management]
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">=1.6.0"
}
