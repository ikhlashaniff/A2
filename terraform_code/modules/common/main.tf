#log analytics workspace resource
resource "azurerm_log_analytics_workspace" "assignment1-log-workspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 100
  tags                = var.tags
}

#recovery services vault resource
resource "azurerm_recovery_services_vault" "assignment1-recovery-vault" {
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  soft_delete_enabled = false
  tags                = var.tags
}

#storage account resource 
resource "azurerm_storage_account" "assignment1-storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #allow_blob_public_access = true
  tags = var.tags
}

