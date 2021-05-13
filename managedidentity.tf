//Managed identity
resource "azurerm_user_assigned_identity" "mi" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  name = format("%s-%s-%s", var.project, var.env, "mi")
  tags = module.ctags.common_tags
}

resource "azurerm_role_assignment" "Reader" {
  principal_id         = azurerm_user_assigned_identity.mi.principal_id
  role_definition_name = "Reader"
  scope                = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_access_policy" "kv-policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.mi.principal_id

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

resource "azurerm_role_assignment" "stgreader" {
  principal_id         = azurerm_user_assigned_identity.mi.principal_id
  role_definition_name = "Reader"
  scope                = azurerm_storage_account.stg.id
}

resource "azurerm_role_assignment" "insightreader" {
  principal_id         = azurerm_user_assigned_identity.mi.principal_id
  role_definition_name = "Reader"
  scope                = azurerm_application_insights.appinsight.id
}

resource "azurerm_role_assignment" "dnszonecontributer" {
  provider             = azurerm.dnszone
  for_each             = toset(var.dns_zones)
  principal_id         = azurerm_user_assigned_identity.mi.principal_id
  role_definition_name = "DNS Zone Contributor"
  scope                = data.azurerm_dns_zone.zone[each.value].id
}
