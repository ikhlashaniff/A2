output "db_server_name" {
  value = azurerm_postgresql_server.assignment1-db_server.name
}

output "db_name" {
  value = azurerm_postgresql_database.assignment1-db-postgre.name
}
