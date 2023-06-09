locals {
  customer_lib          = trimsuffix(var.customer_lib, "/")
  definition_files      = fileset(local.customer_lib, "**/{archetype_definition,policy_assignment,policy_definition,policy_set_definition,role_definition}_*.{json,yml,yaml,json.tftpl,yml.tftpl,yaml.tftpl}")
  definition_files_path = toset([for path in local.definition_files : "${local.customer_lib}/${path}"])
}

resource "local_file" "copied_files" {
  for_each = local.definition_files_path
  source   = each.value
  filename = "${path.module}/customer_lib/${basename(each.key)}"
}

output "merged_library" {
  value       = path.module
  description = "Path to where the library containing both libraries can be found. This output can be given to the CAF-Module."
  depends_on  = [local_file.copied_files]
}

output "file_names" {
  value       = local.definition_files
  description = "Outputs the files which were added to the library."
}
