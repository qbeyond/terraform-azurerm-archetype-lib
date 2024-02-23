resource "azurerm_network_interface" "virtual_machine_before" {
  name                = "nic-UpdatePolicyTest-${random_pet.deploy_maintenance_resources.id}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "before" {
  name                = "vm-UpdatePolicyTest-${random_pet.deploy_maintenance_resources.id}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  computer_name       = "CUSTAPP001"
  network_interface_ids = [
    azurerm_network_interface.virtual_machine_before.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  tags = {
    "Severity Group Monthly" = "01-first-monday-2000-csu-reboot"
    "Update Allowed"         = "Yes"
  }
}


//TODO: Use tests instead of checks maybe?

data "azapi_resource_action" "compliance_state" {
  type                   = "Microsoft.PolicyInsights/policyStates@2019-10-01"
  action                 = "queryResults"
  method                 = "POST"
  resource_id            = "${azurerm_resource_group_policy_assignment.deploy_maintenance_resources.id}/providers/Microsoft.PolicyInsights/policyStates/latest"
  response_export_values = ["*"]
  depends_on             = [azapi_resource_action.evaluation]
}

check "vm_before" {
  assert {
    condition     = one([for result in jsondecode(data.azapi_resource_action.compliance_state.output).value : result if lower(result.resourceId) == lower(azurerm_windows_virtual_machine.before.id)]).isCompliant == false
    error_message = "The vm deployed before the policy should be noncompliant, because no resource were deployed by the policy. This hints, that the resource are already there and your environment isnt clean."
  }
}
