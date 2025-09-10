output "vm_id" {
  description = "The ID of the virtual machine."
  value       = azurerm_linux_virtual_machine.this.id
}

output "vm_name" {
  description = "The name of the virtual machine."
  value       = azurerm_linux_virtual_machine.this.name
}

output "public_ip_address" {
  description = "The public IP address of the virtual machine."
  value       = azurerm_public_ip.this.ip_address
}

output "private_ip_address" {
  description = "The private IP address of the virtual machine."
  value       = azurerm_network_interface.this.private_ip_address
}
