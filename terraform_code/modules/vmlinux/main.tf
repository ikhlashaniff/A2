# Resource block for Linux Availability Set
resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = "2"
  platform_update_domain_count = "5"
  tags                         = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.nb_count
  name                            = "${var.linux_name}-${format("%1d", count.index + 1)}"
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_uname
  admin_password                  = var.admin_password
  disable_password_authentication = false
  tags                            = var.tags
  depends_on                      = [var.rg_name]
  network_interface_ids           = [element(azurerm_network_interface.linux_nic[*].id, count.index + 1)]

  os_disk {
    name                 = "${var.linux_name}-os_disk-${format("%1d", count.index + 1)}"
    caching              = var.os_disk["cache"]
    storage_account_type = var.os_disk["storage"]
    disk_size_gb         = var.os_disk["disk_size_gb"]
  }

  source_image_reference {
    publisher = var.source_image["publisher"]
    offer     = var.source_image["offer"]
    sku       = var.source_image["sku"]
    version   = var.source_image["version"]
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

}

# Resource block for network interface
resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
  depends_on = [
    azurerm_public_ip.public_ip
  ]

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig1-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.public_ip[*].id, count.index + 1)
  }
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.nb_count
  name                = "${var.linux_name}-pip-${format("%1d", count.index + 1)}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.linux_name}-${format("%1d", count.index + 1)}"
  depends_on          = [var.rg_name]
  tags                = var.tags
}

resource "azurerm_virtual_machine_extension" "Network_Watcher" {
  count                      = 2
  name                       = "network-watcher"
  virtual_machine_id         = element(azurerm_linux_virtual_machine.linux_vm[*].id, count.index + 1)
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
}


