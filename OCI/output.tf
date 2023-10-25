output "OCI_Instance_ALL" {
  description = "OCI Instance IDs"
  value = concat(
    module.oci.instance_ids_D
  )
}

output "Foundry_instance_project_D" {
  description = "project_D_instance_ids"
  value       = module.oci.instance_ids_D
}