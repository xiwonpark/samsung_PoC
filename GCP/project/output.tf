output "instance_ids_G" {
  description = "G_project_Instance_ID"
  value       = google_compute_instance.G_Project.*.instance_id
}