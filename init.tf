terraform {
  required_version = ">= 0.15.1"
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.9.0"
      configuration_aliases = [azurerm.dnszone]
    }
  }
}
