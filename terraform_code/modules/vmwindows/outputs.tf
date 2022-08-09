output "windows_vm_hostname" {
  value = azurerm_windows_virtual_machine.windows_vm.computer_name
}

output "windows_Private_IP" {
  value = azurerm_windows_virtual_machine.windows_vm.private_ip_address

}

output "windows_Public_IP" {
  value = azurerm_windows_virtual_machine.windows_vm.public_ip_address

}

output "windows_VM_id" {
  value = azurerm_windows_virtual_machine.windows_vm.id
}

output "windows_vm_nic" {
  value = azurerm_network_interface.windows_nic
}

output "vm_id" {
  value = azurerm_windows_virtual_machine.windows_vm.id
}
