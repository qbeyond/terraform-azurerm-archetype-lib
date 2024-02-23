run "test" {
  command = apply
  module {
    source = "./tests/policy_definition/update_management"
  }
}
