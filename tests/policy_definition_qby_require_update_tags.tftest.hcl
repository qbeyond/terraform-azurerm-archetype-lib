provider "azurerm" {
  features {

  }
}

provider "azurerm" {
  alias = "management"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

run "setup" {
  module {
    source = "./tests/policy_definition/update_management/maintenance_resources_setup"
  }
}

run "vm_before" {
  module {
    source = "./tests/policy_definition/update_management/maintenance_resources_vm"
  }

  variables {
    resource_group = run.setup.resource_group_vm
    random_string  = run.setup.random_string
    subnet         = run.setup.subnet
    severity_group = "01-first-monday-1000-csu-reboot"
  }
}

run "assignment" {
  module {
    source = "./tests/policy_definition/update_management/maintenance_resources_assignment"
  }

  variables {
    policy_definition   = run.setup.policy_definition
    role_definition_ids = run.setup.role_definition_ids
    resource_group      = run.setup.resource_group_vm
  }
}

run "compliance_before_vm" {
  module {
    source = "./tests/policy_definition/update_management/maintenance_resources_compliance"
  }

  variables {
    policy_assignment = run.assignment.policy_assignment
  }
  assert {
    condition     = output.resource_compliance[run.vm_before.id].isCompliant == false
    error_message = "The vm deployed before the policy should be noncompliant, because no resource were deployed by the policy. This hints, that the resource are already there and your environment isnt clean."
  }
}
