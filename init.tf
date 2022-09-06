terraform {
  required_version = ">= 0.15.1"
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.dnszone]
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  alias           = "current_subscription"
}
