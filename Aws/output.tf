# state file에 적을 해당 module의 output 출력
output "AWS_Instance_ALL" {
  description = "AWS Instance IDs"
  value = concat(
    module.aws.instance_ids_A,
    module.aws.instance_ids_B
  )
}

output "instance_project_A" {
  description = "project_A_instance_ids"
  value       = module.aws.instance_ids_A
}

output "instance_project_B" {
  description = "project_B_instance_ids"
  value       = module.aws.instance_ids_B
}
