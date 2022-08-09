#network module output
#name
output "vnet_name" {
  value = azurerm_virtual_network.assignment1-vnet.name
}
#virtual address space
output "vnet_address_space" {
  value = azurerm_virtual_network.assignment1-vnet.address_space
}
#subnet1 name
output "subnet_name" {
  value = azurerm_subnet.assignment1-subnet.name
}
#subnet1 addresss
output "subnet_address_space" {
  value = azurerm_subnet.assignment1-subnet.address_prefixes
}
#subnet1 id 
output "subnet_id" {
  value = azurerm_subnet.assignment1-subnet.id
}
