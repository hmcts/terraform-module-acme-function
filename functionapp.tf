
resource "azurerm_app_service_plan" "asp" {
  location            = var.location
  name                = "${var.product}-${var.env}-asp"
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  reserved            = false
  sku {
    size = var.asp_sku_size
    tier = var.asp_sku_tier
  }
  tags = var.common_tags
}

resource "azurerm_key_vault" "kv" {
  location                  = var.location
  name                      = "acme${replace(local.name, "-", "")}"
  resource_group_name       = azurerm_resource_group.rg.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
  tags                      = var.common_tags
}

resource "azurerm_application_insights" "appinsight" {
  application_type    = "web"
  location            = var.location
  name                = "${var.product}-${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.common_tags
}

resource "azurerm_storage_account" "stg" {
  name                     = "acme${replace(local.name, "-", "")}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.common_tags
}

resource "azurerm_function_app" "funcapp" {
  name                       = "acme${replace(local.name, "-", "")}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.stg.name
  storage_account_access_key = azurerm_storage_account.stg.primary_access_key
  version                    = "~3"

  identity {
    type = "SystemAssigned"
  }

  auth_settings {
    enabled                       = true
    unauthenticated_client_action = "RedirectToLoginPage"
    default_provider              = "AzureActiveDirectory"
    active_directory {
      client_id = azuread_application.appreg.application_id
    }
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.appinsight.instrumentation_key
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
    APPLICATIONINSIGHTS_CONNECTION_STRING      = "InstrumentationKey=${azurerm_application_insights.appinsight.instrumentation_key};IngestionEndpoint=https://uksouth-0.in.applicationinsights.azure.com/"
    AzureWebJobsStorage                        = azurerm_storage_account.stg.primary_connection_string
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING   = azurerm_storage_account.stg.primary_connection_string
    WEBSITE_CONTENTSHARE                       = "${var.product}-${var.env}"
    WEBSITE_RUN_FROM_PACKAGE                   = "https://shibayan.blob.core.windows.net/azure-keyvault-letsencrypt/v3/latest.zip"
    FUNCTIONS_WORKER_RUNTIME                   = "dotnet"
    "Acmebot:AzureDns:SubscriptionId"          = data.azurerm_subscription.dns_zone.subscription_id
    "Acmebot:Contacts"                         = "cnp-acme-owner@hmcts.net"
    "Acmebot:Endpoint"                         = "https://acme-v02.api.letsencrypt.org/"
    "Acmebot:VaultBaseUrl"                     = azurerm_key_vault.kv.vault_uri
    "Acmebot:Environment"                      = "AzureCloud"
  }
  tags = var.common_tags
}

resource "azuread_application" "appreg" {
  display_name = "acme-${lower(data.azurerm_subscription.subscriptionid.display_name)}"
  web {
    redirect_uris = ["https://acme${replace(local.name, "-", "")}.azurewebsites.net/.auth/login/aad/callback"]
  }
  implicit_grant {
    access_token_issuance_enabled = true
    id_token_issuance_enabled     = true
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }
}

resource "azuread_group_member" "dnszonecontributor" {
  group_object_id  = var.dns_contributor_group_id
  member_object_id = azurerm_function_app.funcapp.identity[0].principal_id
}