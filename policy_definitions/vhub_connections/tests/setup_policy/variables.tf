variable "virtual_hub_id" {
  description = "The id of the virtual hub. Used as a parameter for the policy."
  type        = string
}

variable "scope" {
  description = "Scope to assign the policy to"
  type        = string
}

variable "random_string" {
  description = "Random string to use for building names to have the same name across all resources. If not set a random pet will be used."
  type        = string
  default     = null
}
