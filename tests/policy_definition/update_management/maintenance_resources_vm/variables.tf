variable "resource_group" {
  description = "Resource group to deploy the VM to."
  type = object({
    name     = string
    location = string
  })
}

variable "random_string" {
  description = "The random string to make resource names unique."
  type        = string
}

variable "subnet" {
  description = "The subnet to deploy the VM to."
  type = object({
    id = string
  })
}

variable "severity_group" {
  description = "The severity group to assign to the VM."
  type        = string
}
