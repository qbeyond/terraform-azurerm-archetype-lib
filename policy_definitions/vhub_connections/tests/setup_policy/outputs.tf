output "identity_id" {
  description = "The id of the managed identity."
  value       = module.policy_assignment.identity_id
}

output "random_string" {
  description = "The random value used to generate names. May be used for other resources to have the same namings."
  value       = random_pet.this.id
}
