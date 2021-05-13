//Appserviceplan
resource "azurerm_app_service_plan" "asp" {
  location            = var.location
  name                = format("%s-%s-%s", var.project, var.env, "asp")
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  reserved            = false
  sku {
    size = var.aspskusize
    tier = var.aspskutier
  }
  tags = module.ctags.common_tags
}


//Azure keyvault
resource "azurerm_key_vault" "kv" {
  location            = var.location
  name                = format("%s%s", var.project, var.env)
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = module.ctags.common_tags
}


//Azure app insights
resource "azurerm_application_insights" "appinsight" {
  application_type    = "web"
  location            = var.location
  name                = format("%s-%s", var.project, var.env)
  resource_group_name = azurerm_resource_group.rg.name
  tags                = module.ctags.common_tags
}

//Azure storage account
resource "azurerm_storage_account" "stg" {
  name                     = format("%s%s%s", var.project, var.env, "stg")
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = module.ctags.common_tags
}

resource "azurerm_function_app" "funcapp" {
  name                       = format("%s-%s", var.project, var.env)
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.stg.name
  storage_account_access_key = azurerm_storage_account.stg.primary_access_key
  version                    = "~3"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.mi.id]
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
    WEBSITE_CONTENTSHARE                       = format("%s-%s", var.project, var.env)
    WEBSITE_RUN_FROM_PACKAGE                   = "https://shibayan.blob.core.windows.net/azure-keyvault-letsencrypt/v3/latest.zip"
    FUNCTIONS_WORKER_RUNTIME                   = "dotnet"
    "Acmebot:AzureDns:SubscriptionId"          = var.dns_zone_subscription_id
    "Acmebot:Contacts"                         = "cnp-acme-owner@hmcts.net"
    "Acmebot:Endpoint"                         = "https://acme-v02.api.letsencrypt.org/"
    "Acmebot:VaultBaseUrl"                     = azurerm_key_vault.kv.vault_uri
    "Acmebot:Environment"                      = "AzureCloud"
  }
  tags = module.ctags.common_tags
}


//Cname record entry
resource "azurerm_private_dns_cname_record" "cname" {
  provider            = azurerm.privatezone
  name                = azurerm_function_app.funcapp.name
  zone_name           = local.private_dns_mapping[var.env].dns_zone
  resource_group_name = local.private_dns_mapping[var.env].resource_group
  ttl                 = var.dns_ttl
  record              = format("%s-%s%s", var.project, var.env, ".azurewebsites.net")
}

//app registration
resource "azuread_application" "appreg" {
  name                       = format("%s-%s", var.project, var.env)
  reply_urls                 = [format("%s%s-%s%s", "https://", var.project, var.env, ".azurewebsites.net/.auth/login/aad/callback")]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}
