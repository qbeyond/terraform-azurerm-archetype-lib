terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.13.1"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
