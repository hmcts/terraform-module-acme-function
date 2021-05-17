terraform {
  required_version = ">= 0.15.1"
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=2.58.0"
      configuration_aliases = [azurerm.dnszone, azurerm.privatezone]
    }
  }
}

provider "azurerm" {
  features {}
}
provider "azuread" {
}

