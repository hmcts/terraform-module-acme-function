locals {
  name = replace(lower(data.azurerm_subscription.subscriptionid.subscription_name), "sharedservices", "sds")

}
