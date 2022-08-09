
# Linux data-disk
resource "azurerm_managed_disk" "assignment1-data-disk-linux" {
  count                = 2
  name                 = "${element(var.linux_name[*], count.index + 1)}-data-disk"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}


resource "azurerm_virtual_machine_data_disk_attachment" "assignment1-attach-disk-linux" {
  count              = 2
  virtual_machine_id = element(var.linux_id[*], count.index + 1)
  managed_disk_id    = element(azurerm_managed_disk.assignment1-data-disk-linux[*].id, count.index + 1)
  lun                = 0
  caching            = "ReadWrite"
  depends_on = [
    azurerm_managed_disk.assignment1-data-disk-linux
  ]
}

#windows data-disk
resource "azurerm_managed_disk" "assignment1-data-disk-windows" {
  name                 = "${(var.windows_name)}-data-disk"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}


resource "azurerm_virtual_machine_data_disk_attachment" "assignment1-attach-disk-windows" {
  virtual_machine_id = var.windows_id
  managed_disk_id    = azurerm_managed_disk.assignment1-data-disk-windows.id
  lun                = "10"
  caching            = "ReadWrite"
  depends_on = [
    azurerm_managed_disk.assignment1-data-disk-windows
  ]

}
