variable "random_string" {
  description = "Random string to use for building names to have the same name across all resources. If not set a random pet will be used."
  type        = string
  default     = null
}
