locals {
  template_path = replace(var.policy_file_path, "/.json$/", "_ARM.json")
  template      = jsondecode(file(local.template_path))
  policy_input  = jsondecode(file(var.policy_file_path))

  deployment_properties = merge(local.policy_input["properties"]["policyRule"]["then"]["details"]["deployment"]["properties"], {
    template = local.template
  })
  deployment = merge(local.policy_input["properties"]["policyRule"]["then"]["details"]["deployment"], {
    properties = local.deployment_properties
  })
  details = merge(local.policy_input["properties"]["policyRule"]["then"]["details"], {
    deployment = local.deployment
  })
  then = merge(local.policy_input["properties"]["policyRule"]["then"], {
    details = local.details
  })
  policyRule = merge(local.policy_input["properties"]["policyRule"], {
    then = local.then
  })
  properties = merge(local.policy_input["properties"], {
    policyRule = local.policyRule
  })
  policy = merge(local.policy_input, {
    properties = local.properties
  })
}

output "policy" {
  value       = local.policy
  description = "The merged policy JSON with the ARM template as terraform object."
}
