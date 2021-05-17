resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = format("%s-%s-%s", var.product, var.env, "rg")
  tags     = var.common_tags
}

