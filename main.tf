locals {
  customer_lib         = trimsuffix(var.customer_lib, "/")
  definiton_files      = fileset(local.customer_lib, "**/{archetype_definition,policy_assignment,policy_definition,policy_set_definition,role_definition}_*.{json,yml,yaml,json.tftpl,yml.tftpl,yaml.tftpl}")
  definiton_files_path = toset([for path in local.definiton_files : "${local.customer_lib}/${path}"])
}

resource "local_file" "created_file" {
  for_each = local.definiton_files_path
  source   = each.value
  filename = "${path.module}/customer_lib/${basename(each.key)}"
}

output "merged_libraries" {
  depends_on  = [local_file.created_file]
  value       = path.module
  description = "path to were the merged librarys are found. Can be given to the CAF"
}

output "filenames" {
  value       = local.definiton_files
  description = "outputs the files wich were added to the library"
}
