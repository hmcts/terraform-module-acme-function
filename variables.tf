variable "location" {
  description = "Azure location to deploy the resource."
  type        = string
  default     = "UK South"
}
variable "env" {
  description = "Name of the environment to deploy the resource."
  type        = string
}
variable "product" {
  description = "Name of the product."
  type        = string
  default     = "acme"
}

variable "aspskusize" {
  default     = "Y1"
  description = "SKU size for App Service Plan."
}
variable "aspskutier" {
  default     = "Dynamic"
  description = "SKU tier for App Service Plan."
}

variable "dns_zones" {
  type        = list(any)
  description = "List of DNS Zones."
}

variable "dns_zone_rg" {
  default     = "reformMgmtRG"
  description = "Name of the resource group DNS Zones belongs to."
}

variable "common_tags" {
  description = "Common tag to be applied"
  type        = map(string)
}