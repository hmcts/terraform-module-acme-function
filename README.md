# https://github.com/hmcts/terraform-module-acme-function

Terraform module to create a Function App which automates certificate management.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.58.0 |
| <a name="provider_azurerm.dnszone"></a> [azurerm.dnszone](#provider\_azurerm.dnszone) | =2.58.0 |
| <a name="provider_azurerm.privatezone"></a> [azurerm.privatezone](#provider\_azurerm.privatezone) | =2.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.appreg](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azurerm_app_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/app_service_plan) | resource |
| [azurerm_application_insights.appinsight](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/application_insights) | resource |
| [azurerm_function_app.funcapp](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/function_app) | resource |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.groupaccess](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.kv-policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_private_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/private_dns_cname_record) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.Reader](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dnszonecontributer](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.stg](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/storage_account) | resource |
| [azuread_groups.groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/groups) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/data-sources/client_config) | data source |
| [azurerm_dns_zone.zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/data-sources/dns_zone) | data source |
| [azurerm_subscription.subid](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aspskusize"></a> [aspskusize](#input\_aspskusize) | SKU size for App Service Plan. | `string` | `"Y1"` | no |
| <a name="input_aspskutier"></a> [aspskutier](#input\_aspskutier) | SKU tier for App Service Plan. | `string` | `"Dynamic"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied | `map(string)` | n/a | yes |
| <a name="input_dns_zone_rg"></a> [dns\_zone\_rg](#input\_dns\_zone\_rg) | Name of the resource group DNS Zones belongs to. | `string` | `"reformMgmtRG"` | no |
| <a name="input_dns_zones"></a> [dns\_zones](#input\_dns\_zones) | List of DNS Zones. | `list(any)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the environment to deploy the resource. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location to deploy the resource. | `string` | `"UK South"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product. | `string` | `"acme"` | no |

## Outputs

No outputs.
