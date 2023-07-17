variable "virtual_network_name" {
  type        = string
  description = "Name of the vNet. Used to build the name of the connection by adding `to-vhub`"
}

variable "virtual_hub" {
  type = object({
    id = string
  })
  description = "Information of the virtual hub, the connection should be deployed to."
}
