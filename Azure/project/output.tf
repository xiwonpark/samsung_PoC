output "instance_ids_C" {
  description = "C_Project Instance ID"
  value       = azurerm_linux_virtual_machine.C_Project.*.id
}
