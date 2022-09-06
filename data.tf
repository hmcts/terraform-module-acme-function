data "azurerm_client_config" "current" {

}
data "azurerm_subscription" "dns_zone" {}

data "azuread_group" "group" {
  display_name     = "DTS Platform Operations"
  security_enabled = true
}

data "azurerm_subscription" "subscriptionid" {
  subscription_id = var.subscription_id
}

data "azuread_group" "dns_contributor" {
  display_name = "DTS Public DNS Contributor (env:${lower(var.env)})"
}