#common outputs

#log analytics name
output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.assignment1-log-workspace.name
}
#recovery services name
output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.assignment1-recovery-vault.name
}
#storage account name
output "storage_account_name" {
  value = azurerm_storage_account.assignment1-storage-account.name
}


#storage account uniform resource identifier 
output "storage_account_uri" {
  value = azurerm_storage_account.assignment1-storage-account.primary_blob_endpoint
}

