data "azurerm_client_config" "current" {}
data "azurerm_dns_zone" "zone" {
  provider            = azurerm.dnszone
  for_each            = toset(var.dns_zones)
  name                = each.value
  resource_group_name = var.dns_zone_rg
}