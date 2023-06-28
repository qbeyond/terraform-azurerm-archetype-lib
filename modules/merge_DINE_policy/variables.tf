variable "policy_file_path" {
  type        = string
  description = "The path to the policy JSON containing everything except the ARM-template."

  validation {
    condition     = fileexists(var.policy_file_path)
    error_message = "The provided file must exist."
  }

  validation {
    condition     = length(regexall("\\.json$", var.policy_file_path)) > 0
    error_message = "The provided file must be a JSON file."
  }
}
