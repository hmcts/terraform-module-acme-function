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
}
variable "builtFrom" {
  description = "Name of the GitHub repository this application is being built from."
  type        = string
}
variable "project" {
  default     = "acme"
  description = "Name of the project."
}
variable "aspskusize" {
  default     = "Y1"
  description = "SKU size for App Service Plan."
}
variable "aspskutier" {
  default     = "Dynamic"
  description = "SKU tier for App Service Plan."
}

variable "dns_zone_subscription_id" {
  default     = "ed302caf-ec27-4c64-a05e-85731c3ce90e" //Reform-CFT-Mgmt
  description = "Enter Subscription ID for dns zones."

}
variable "dns_zones" {
  type        = list(any)
  description = "List of DNS Zones."
}
variable "dns_ttl" {
  default     = 300
  description = "TTL value."
}
variable "dns_zone_rg" {
  default     = "reformMgmtRG"
  description = "Name of the resource group DNS Zones belongs to."
}