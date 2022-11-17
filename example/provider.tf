terraform {
  required_version = ">= 0.15.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.31.0"
    }
  }
}

provider "azurerm" {
  features {}
}
provider "azuread" {
}

provider "azurerm" {
  features {}
  subscription_id = "ed302caf-ec27-4c64-a05e-85731c3ce90e"
  alias           = "dnszones"
}