data "azurerm_client_config" "current" {

}
data "azurerm_subscription" "dns_zone" {
  provider = azurerm.dnszone
}

data "azuread_group" "group" {
  display_name = "DTS Platform Operations"
}

data "azurerm_subscription" "subscriptionid" {}