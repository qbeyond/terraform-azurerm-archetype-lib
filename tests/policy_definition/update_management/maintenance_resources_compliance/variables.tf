variable "policy_assignment" {
  description = "The policy assignment to check for compliance."
  type = object({
    id              = string
    subscription_id = string
  })
}
