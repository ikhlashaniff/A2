
# Variables for Availability Set
variable "linux_avs" {
  description = "This is for Linux Availability Set"
}

variable "linux_nic" {
}

variable "location" {
  description = "This is the location where all the infrastructure will be deployed"
}

variable "rg_name" {
  description = "This is the resource group where all resources will be deployed"
}

# Variable for Count
variable "nb_count" {
  description = "This is the count metadata which will be used while creating resources"
}

# Variable for Virtual Machine Resouces
variable "linux_name" {
  # default = "lab02s3-db1-u-vm1"
}

variable "size" {
  # default = "Standard_B1s"
}

variable "admin_uname" {
  default = "Ikhlas-N01227514"
}

variable "admin_password" {
  default = "Pa$$w0rd"
}

variable "os_disk" {
  type = map(string)
  default = {
    cache        = "ReadWrite"
    storage      = "Premium_LRS"
    disk_size_gb = "32"
  }
}

variable "source_image" {
  type = map(string)
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "8.2.2020111800"
  }
}

# Variable related to network in VM
variable "subnet_id" {

}

variable "tags" {

}

variable "storage_account_uri" {

}

