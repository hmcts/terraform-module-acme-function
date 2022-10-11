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

variable "common_tags" {
  description = "Common tag to be applied"
  type        = map(string)
}

variable "acme_storage_account_repl_type" {
  description = "Replication type for acme storage account"
}

variable "subscription_id" {}

# variable "asp_id" {}

# variable "resource_group_id" {}

# variable "resource_group_name" {}

variable "allow_nested_items_to_be_public" {
  default = false
}