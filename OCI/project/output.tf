output "instance_ids_D" {
  description = "D_Project Instance ID"
  value       = oci_core_instance.D_project.*.id
}