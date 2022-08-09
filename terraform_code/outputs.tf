#resource group output 
output "rgroup" {
  value = module.rgroup.rg_name
}

#network output
output "location" {
  value = module.rgroup.location_name
}

output "vnet_name" {
  value = module.network.vnet_name
}
output "vnet_address_space" {
  value = module.network.vnet_address_space
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "subnet_address_space" {
  value = module.network.subnet_address_space
}

#common output
output "recovery_vault_name" {
  value = module.common.recovery_services_vault_name
}

output "log_analytics_workspace" {
  value = module.common.log_analytics_workspace_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

#Output for Linux VM Module

output "vm_hostname" {
  value = module.vmlinux.vm_hostname
}

output "vm_id" {
  value = module.vmlinux.vm_id
}


output "linux_private_ip" {
  value = module.vmlinux.private_ip
}

output "linux_public_ip" {
  value = module.vmlinux.public_ip
}

output "linux_vm_dns_names" {
  value = module.vmlinux.vm_dns_names
}

output "linux_nic" {
  value = module.vmlinux.linux_nic

}

#Output for Windows VM Module
output "windows_vm_hostname" {
  value = module.vmwindows.windows_vm_hostname
}

output "windows_Private_IP" {
  value = module.vmwindows.windows_Private_IP

}

output "windows_Public_IP" {
  value = module.vmwindows.windows_Public_IP

}

output "windows_vm_id" {
  value = module.vmwindows.vm_id
}

#Output for LB Module
output "Loadbalancer_name" {
  value = module.loadbalancer.load_balancer_name
}

#Output for database

output "database_name" {
  value = module.database.db_name
}

output "database_server_name" {
  value = module.database.db_server_name
}
