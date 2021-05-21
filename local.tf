locals {
  name = replace(lower(data.azurerm_subscription.subscriptionid.display_name), "-", "")

}