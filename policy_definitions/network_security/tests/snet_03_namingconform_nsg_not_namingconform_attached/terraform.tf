terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ec94001e-0aa8-4c0d-a36c-b5ce4feca21f"
  skip_provider_registration = true
}