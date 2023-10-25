output "GCP_Instance_ALL" {
  description = "GCP Instance IDs"
  value = concat(
    module.gcp.instance_ids_G
  )
}

output "instance_project_G" {
  description = "project_G_instance_ids"
  value       = module.gcp.instance_ids_G
}