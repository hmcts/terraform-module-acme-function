/**
 * # terraform-module-acme-function
 *
 * Terraform module to create a Function App which automates certificate management.
 *
 * 
 */

 resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.product}-${var.env}-rg"
  tags     = var.common_tags
}

resource "azurerm_service_plan" "asp" {
  location            = var.location
  name                = "${var.product}-${var.env}-asp"
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = var.sp_sku_name
  tags                = var.common_tags
}
