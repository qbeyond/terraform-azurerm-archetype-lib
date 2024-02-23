variable "policy_definition" {
  description = "The policy definitin of deploy maintenance resources policy"
  type = object({
    name         = string
    id           = string
    description  = string
    display_name = string
  })
}


variable "role_definition_ids" {
  description = "The ids of the role definitions to assign to the policy assignment."
  type        = list(string)
}

variable "resource_group" {
  description = "The resource group the maintenance configuration should be deployed to."
  type = object({
    name     = string
    location = string
  })
}
