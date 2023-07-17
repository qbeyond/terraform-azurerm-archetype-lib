variable "virtual_network" {
  type = object({
    name = string
    id   = string
  })
  description = "Data of the vNet. Used to build the name of the connection by adding `to-vhub` and verify the deployed connection."
}

variable "virtual_hub" {
  type = object({
    id = string
  })
  description = "Information of the virtual hub, the connection should be deployed to."
}
