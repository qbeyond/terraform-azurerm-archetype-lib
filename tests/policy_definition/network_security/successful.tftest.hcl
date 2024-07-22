# requires ./00_setup_policy_deployment to be deployed
# Run all tests that should be successful
# Tests that are expected to fail are unfortunately not supported by terraform test
# run the remaining tests manually

run "nsg_02_allowed_namingconform_deny_all_inbound_as_last_rule" {
  module {
    source = "./nsg_02_allowed_namingconform_deny_all_inbound_as_last_rule"
  }
}

run "nsg_03_allowed_namingconform_deny_all_inbound_as_middle_rule" {
  module {
    source = "./nsg_03_allowed_namingconform_deny_all_inbound_as_middle_rule"
  }
}

run "snet_01_allowed_namingconform_correct_nsg_attached" {
  module {
    source = "./snet_01_allowed_namingconform_correct_nsg_attached"
  }
}
run "snet_07_allowed_namingconform_exemption_subnets_no_nsg_attached" {
  module {
    source = "./snet_07_allowed_namingconform_exemption_subnets_no_nsg_attached"
  }
}

run "vNet_01_allowed_namingconform" {
  module {
    source = "./vNet_01_allowed_namingconform"
  }
}
