# terraform-module-acme-function

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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.appreg](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_group_member.dnszonecontributor](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azurerm_app_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/app_service_plan) | resource |
| [azurerm_application_insights.appinsight](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/application_insights) | resource |
| [azurerm_function_app.funcapp](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/function_app) | resource |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/key_vault) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.Reader](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kvaccess](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kvgroupaccess](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.stg](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/resources/storage_account) | resource |
| [azuread_group.group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/data-sources/client_config) | data source |
| [azurerm_subscription.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/data-sources/subscription) | data source |
| [azurerm_subscription.subscriptionid](https://registry.terraform.io/providers/hashicorp/azurerm/2.58.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asp_sku_size"></a> [asp\_sku\_size](#input\_asp\_sku\_size) | SKU size for App Service Plan. | `string` | `"Y1"` | no |
| <a name="input_asp_sku_tier"></a> [asp\_sku\_tier](#input\_asp\_sku\_tier) | SKU tier for App Service Plan. | `string` | `"Dynamic"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied | `map(string)` | n/a | yes |
| <a name="input_dns_contributor_group_id"></a> [dns\_contributor\_group\_id](#input\_dns\_contributor\_group\_id) | DTS Public DNS Contributor group | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the environment to deploy the resource. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location to deploy the resource. | `string` | `"UK South"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product. | `any` | n/a | yes |

## Outputs

No outputs.
