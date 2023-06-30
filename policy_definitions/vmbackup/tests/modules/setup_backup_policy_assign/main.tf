terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  skip_provider_registration = true
}

locals {
  rg_name = var.rg_name
  rsv_name =var.rsv_name
}

resource "azurerm_resource_group" "backup_policy" {
  name     = local.rg_name
  location = "westeurope"
}

resource "azurerm_recovery_services_vault" "backup_policy" {
  name                = var.rsv_name
  location            = "westeurope"
  resource_group_name = local.rg_name
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = "QbyDefault"
  resource_group_name = local.rg_name
  recovery_vault_name = azurerm_recovery_services_vault.backup_policy.name

  timezone = "UTC"

  backup {
    frequency = "Hourly"
    time      = "00:00"
    hour_interval = 4
  }

  retention_daily {
    count = 7
  }

  retention_weekly {
    count    = 4
    weekdays = ["Monday"]
  }
}

resource "azurerm_backup_protected_vm" "backup_policy" {
  resource_group_name = local.rg_name
  recovery_vault_name = local.rsv_name
  source_vm_id        = var.vm_id
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy.id
}

# module "vm_backup" {
#   source = "value"
#   version = "value"

#   resource_group_name = local.rg_name
#   backup_recovery_vault_name = local.rsv_name

#   vm_id = "" # hier die id der vm aus dem anderen module
# }