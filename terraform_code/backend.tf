terraform {

  backend "azurerm" {
    resource_group_name  = "tfstate-N01227514-RG"
    storage_account_name = "tfstaten01227514sag"
    container_name       = "tfstatefiles"
    key                  = "tfstatefile"
  }
}
