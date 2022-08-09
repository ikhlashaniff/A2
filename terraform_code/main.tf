#resource group module 
module "rgroup" {
  source   = "./modules/rgroup"
  location = "australiaeast"
  rg_name  = "7514-assignment1-RG"
  tags     = local.common_tags
}

#network module
module "network" {
  source               = "./modules/network"
  rg_name              = module.rgroup.rg_name
  location             = module.rgroup.location_name
  vnet_name            = "7514-vnet"
  vnet_address_space   = ["10.0.0.0/16"]
  subnet_name          = "7514-subnet"
  subnet_address_space = ["10.0.0.0/24"]
  nsg_name             = "7514-nsg"
  tags                 = local.common_tags
  depends_on = [
    module.rgroup
  ]
}

#common module 
module "common" {
  source                       = "./modules/common"
  recovery_services_vault_name = "vault-7514"
  log_analytics_workspace_name = "7514-log-analytics-workspace"
  storage_account_name         = "7514storageaccount"
  location                     = module.rgroup.location_name
  rg_name                      = module.rgroup.rg_name
  tags                         = local.common_tags
  depends_on = [
    module.rgroup,
  ]
}

#Linux VM module
module "vmlinux" {
  source              = "./modules/vmlinux"
  rg_name             = module.rgroup.rg_name
  location            = module.rgroup.location_name
  linux_avs           = "Linux7514_AVS"
  nb_count            = 2
  linux_name          = "linux-7514-vm"
  linux_nic           = module.vmlinux.linux_nic
  size                = "Standard_B1s"
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_uri
  tags                = local.common_tags
  depends_on = [
    module.rgroup,
    module.network
  ]

}

# Windows VM Module
module "vmwindows" {
  source              = "./modules/vmwindows"
  windows_name        = "win-7514-vm"
  windows_avs         = "Windows7514_AVS"
  location            = module.rgroup.location_name
  rg_name             = module.rgroup.rg_name
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_uri
  tags                = local.common_tags
  depends_on = [
    module.rgroup,
    module.network
  ]
}

#data disk module
module "datadisk" {
  source       = "./modules/datadisk"
  location     = module.rgroup.location_name
  rg_name      = module.rgroup.rg_name
  linux_name   = module.vmlinux.vm_hostname
  linux_id     = module.vmlinux.vm_id
  windows_name = module.vmwindows.windows_vm_hostname
  windows_id   = module.vmwindows.vm_id
  tags         = local.common_tags
  depends_on = [
    module.vmwindows,
    module.vmlinux
  ]
}

#LB Module
module "loadbalancer" {
  source            = "./modules/loadbalancer"
  lb_name           = "assignment1-lb"
  public_ip_lb_name = "lb-pip"
  location          = module.rgroup.location_name
  rg_name           = module.rgroup.rg_name
  subnet_id         = module.network.subnet_id
  linux_nic         = module.vmlinux.linux_nic
  tags              = local.common_tags
  depends_on = [
    module.datadisk
  ]

}

#database module
module "database" {
  source         = "./modules/database"
  db_server_name = "postgre-server7514"
  db_name        = "postgre_server-db7514"
  location       = module.rgroup.location_name
  rg_name        = module.rgroup.rg_name
  tags           = local.common_tags
  /*depends_on = [
    module.loadbalancer
  ]*/

}
