terraform {
  required_version = ">= 0.15.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.58.0"
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

provider "azurerm" {
  features {}
  subscription_id = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
  alias           = "privatezones"
}

module "acme" {
  source = "git::https://github.com/hmcts/terraform-module-acme-function.git?ref=master"
  providers = {
    azurerm.dnszone     = azurerm.dnszones
    azurerm.privatezone = azurerm.privatezones
  }
  location  = "uk south"
  env       = "sbox"
  dns_zones = ["sandbox.platform.hmcts.net"]
  common_tags = {
    app = "acme"
  }
}