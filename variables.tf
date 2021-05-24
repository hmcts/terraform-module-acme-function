variable "location" {
  description = "Azure location to deploy the resource."
  default     = "UK South"
}
variable "env" {
  description = "Name of the environment to deploy the resource."
  type        = string
}
variable "product" {
  description = "Name of the product."
}

variable "asp_sku_size" {
  default     = "Y1"
  description = "SKU size for App Service Plan."
}
variable "asp_sku_tier" {
  default     = "Dynamic"
  description = "SKU tier for App Service Plan."
}

variable "dns_zone_rg" {
  default     = "reformMgmtRG"
  description = "Name of the resource group DNS Zones belongs to."
}

variable "common_tags" {
  description = "Common tag to be applied"
  type        = map(string)
}

variable "dns_contributor_group" {
  description = "DTS Public DNS Contributor group"
}