resource "azurerm_resource_group" "rg" {
  provider = azurerm.subscriptionid
  location = var.location
  name     = "${var.product}-${var.env}-rg"
  tags     = var.common_tags
}

