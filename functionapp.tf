resource "azurerm_key_vault" "kv" {
  location                  = var.location
  name                      = "acme${replace(local.name, "-", "")}"
  resource_group_name       = azurerm_resource_group.rg.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
  tags                      = var.common_tags
  enabled_for_deployment    = true
}

resource "azurerm_application_insights" "appinsight" {
  application_type    = "web"
  location            = var.location
  name                = "acme${replace(local.name, "-", "")}"
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.common_tags
}

resource "azurerm_storage_account" "stg" {
  name                            = "acme${replace(local.name, "-", "")}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = var.acme_storage_account_repl_type
  tags                            = var.common_tags
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
}

resource "azurerm_windows_function_app" "funcapp" {
  name                = "acme${replace(local.name, "-", "")}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  storage_account_name       = azurerm_storage_account.stg.name
  storage_account_access_key = azurerm_storage_account.stg.primary_access_key
  service_plan_id            = azurerm_service_plan.asp.id

  site_config {
    application_insights_connection_string = "InstrumentationKey=${azurerm_application_insights.appinsight.instrumentation_key};IngestionEndpoint=https://uksouth-0.in.applicationinsights.azure.com/"
  }

  identity {
    type = "SystemAssigned"
  }

  auth_settings {
    enabled                       = true
    unauthenticated_client_action = "RedirectToLoginPage"
    default_provider              = "AzureActiveDirectory"
    active_directory {
      client_id = var.application_id
    }
  }
  app_settings = {
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING   = azurerm_storage_account.stg.primary_connection_string
    WEBSITE_CONTENTSHARE                       = "${var.product}-${var.env}"
    WEBSITE_RUN_FROM_PACKAGE                   = "https://stacmebotprod.blob.core.windows.net/keyvault-acmebot/v4/latest.zip"
    FUNCTIONS_WORKER_RUNTIME                   = "dotnet"
    "Acmebot:AzureDns:SubscriptionId"          = data.azurerm_subscription.dns_zone.subscription_id
    "Acmebot:Contacts"                         = "cnp-acme-owner@hmcts.net"
    "Acmebot:Endpoint"                         = "https://acme-v02.api.letsencrypt.org/"
    "Acmebot:VaultBaseUrl"                     = azurerm_key_vault.kv.vault_uri
    "Acmebot:Environment"                      = "AzureCloud"
  }
  tags = var.common_tags
}

resource "azuread_group_member" "dnszonecontributor" {
  group_object_id  = var.dns_contributor_group
  member_object_id = azurerm_windows_function_app.funcapp.identity[0].principal_id
}