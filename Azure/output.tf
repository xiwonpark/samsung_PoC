# state file에 적을 해당 module의 output 출력
output "Azure_Instance_ALL" {
  description = "Azure Instance IDs"
  value = concat(
    module.azure.instance_ids_C
  )
}

output "instance_project_C" {
  description = "project_A_instance_ids"
  value       = module.azure.instance_ids_C
}