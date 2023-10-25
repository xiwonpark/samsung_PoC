output "instance_ids_A" {
  description = "A_Project Instance ID"
  value       = aws_instance.A_Project.*.id
}

output "instance_ids_B" {
  description = "B_Project Instance ID"
  value       = aws_instance.B_Project.*.id
}