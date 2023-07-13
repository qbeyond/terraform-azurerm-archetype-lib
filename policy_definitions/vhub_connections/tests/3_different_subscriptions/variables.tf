variable "subscription_id_hub" {
  description = "The id of the subscription to deploy the VHub to. Should not be the current selected subscription!"
  type        = string
}

variable "exercise" {
  description = "Should the test be exercised by deploying a VNet."
  type        = string
}
