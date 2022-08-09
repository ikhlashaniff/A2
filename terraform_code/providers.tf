provider "azurerm" {
  features {}
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6.0"
    }
  }
  required_version = "~> 1.1.9"
}

locals {
  common_tags = {
    Project        = "Automation Project - Assignment 1"
    Name           = "Ikhlas Haniff"
    ExpirationDate = "2022-06-30"
    Environment    = "Lab"
  }
}
