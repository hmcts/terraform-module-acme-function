# terraform-module-acme-function
Automatic Certificate Management
# https://github.com/hmcts/terraform-module-acme-function

Terraform module to create a Function App which automates certificate management.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.6 |
| azurerm | =2.58.0 |

## Providers

| Name | Version |
|------|---------|
| azuread | n/a |
| azurerm | =2.58.0 |
| azurerm.dnszone | =2.58.0 |
| azurerm.privatezone | =2.58.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aspskusize | SKU size for App Service Plan. | `string` | `"Y1"` | no |
| aspskutier | SKU tier for App Service Plan. | `string` | `"Dynamic"` | no |
| builtFrom | Name of the GitHub repository this application is being built from. | `string` | n/a | yes |
| dns\_ttl | TTL value. | `number` | `300` | no |
| dns\_zone\_rg | Name of the resource group DNS Zones belongs to. | `string` | `"reformMgmtRG"` | no |
| dns\_zone\_subscription\_id | Enter Subscription ID for dns zones. | `string` | `"ed302caf-ec27-4c64-a05e-85731c3ce90e"` | no |
| dns\_zones | List of DNS Zones. | `list(any)` | n/a | yes |
| env | Name of the environment to deploy the resource. | `string` | n/a | yes |
| location | Azure location to deploy the resource. | `string` | `"UK South"` | no |
| product | Name of the product. | `string` | n/a | yes |
| project | Name of the project. | `string` | `"acme"` | no |

## Outputs

No output.

