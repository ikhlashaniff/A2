# Variables for Windows Module


# Variable for windows availability set
variable "windows_avs" {
}

# Variables for Virtual Machine Resources
variable "windows_name" {

}

variable "windows_vm_size" {
  default = "Standard_B1s"
}

variable "windows_admin_username" {
  default = "ikhlas-n01227514"
}

variable "windows_admin_password" {
  default = "Pa$$w0rd123!"
}


variable "windows_os_disk" {
  type = map(string)
  default = {
    cache        = "ReadWrite"
    storage      = "StandardSSD_LRS"
    disk_size_gb = "128"
  }
}

variable "windows_source_image" {
  type = map(string)
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

variable "location" {
}
variable "rg_name" {
}
variable "tags" {

}

variable "subnet_id" {
}

variable "storage_account_uri" {

}
