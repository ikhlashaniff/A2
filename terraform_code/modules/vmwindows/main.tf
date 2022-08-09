resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = var.windows_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.windows_vm_size
  availability_set_id = azurerm_availability_set.windows_avs.id
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.windows_nic.id
  ]
  winrm_listener {
    protocol = "Http"
  }
  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }



  os_disk {
    name                 = "vmwindows-7514-os-disk"
    caching              = var.windows_os_disk["cache"]
    storage_account_type = var.windows_os_disk["storage"]
    disk_size_gb         = var.windows_os_disk["disk_size_gb"]
  }

  source_image_reference {
    publisher = var.windows_source_image["publisher"]
    offer     = var.windows_source_image["offer"]
    sku       = var.windows_source_image["sku"]
    version   = var.windows_source_image["version"]
  }


  tags = var.tags
  lifecycle {
  }
}

resource "azurerm_network_interface" "windows_nic" {
  name                = "vmwindows-7514-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "vmwindows-7514-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip.id
  }
  tags = var.tags
  lifecycle {

  }
}

resource "azurerm_public_ip" "windows_pip" {
  name                = "vmwindows-7514-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
  tags                = var.tags
  domain_name_label   = var.windows_name
  lifecycle {

  }
}

resource "azurerm_virtual_machine_extension" "windows_extension" {
  name                       = "antimalware_extension"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = "true"

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": "true",
        "ScheduledScanSettings":{
          "isEnabled": "true",
          "day": "1",
          "time": "120",
          "scanType": "Quick"
        },
        "Exclusions": {
          "Extensions": "",
          "Paths": "",
          "Processes": ""
        }
    }
SETTINGS

  depends_on = [
    azurerm_windows_virtual_machine.windows_vm
  ]

  tags = var.tags
}
