#resource group module outputs
#name output 
output "rg_name" {
  value = azurerm_resource_group.assignment1-rg.name
}
#location output
output "location_name" {
  value = azurerm_resource_group.assignment1-rg.location
}

