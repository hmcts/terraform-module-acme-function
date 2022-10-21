data "azurerm_client_config" "current" {

}
data "azurerm_subscription" "dns_zone" {}

data "azurerm_subscription" "subscriptionid" {
  subscription_id = var.subscription_id
}
