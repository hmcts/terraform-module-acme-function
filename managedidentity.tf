resource "azurerm_role_assignment" "Reader" {
  principal_id         = azurerm_function_app.funcapp.identity[0].principal_id
  role_definition_name = "Reader"
  scope                = azurerm_resource_group.rg.id
}

resource "azurerm_role_assignment" "dnszonecontributer" {
  provider             = azurerm.dnszone
  for_each             = toset(var.dns_zones)
  principal_id         = azurerm_function_app.funcapp.identity[0].principal_id
  role_definition_name = "DNS Zone Contributor"
  scope                = data.azurerm_dns_zone.zone[each.value].id
}

resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_function_app.funcapp.identity[0].principal_id

  key_permissions = [
    "get",
    "list",
  ]
  secret_permissions = [
    "get",
    "list",
  ]
  certificate_permissions = [
    "list",
    "update",
    "create",
    "import",
    "delete",
    "managecontacts",
    "manageissuers",
    "getissuers",
    "listissuers",
    "setissuers",
    "deleteissuers",
  ]
}

resource "azurerm_key_vault_access_policy" "groupaccess" {
  for_each     = toset(data.azuread_groups.groups.object_ids)
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  key_permissions = [
    "get",
    "list",
  ]
  secret_permissions = [
    "get",
    "list",
  ]
  certificate_permissions = [
    "list",
    "update",
    "create",
    "import",
    "delete",
    "managecontacts",
    "manageissuers",
    "getissuers",
    "listissuers",
    "setissuers",
    "deleteissuers",
  ]
}