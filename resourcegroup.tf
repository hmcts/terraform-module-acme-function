resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = format("%s-%s-%s", var.project, var.env, "rg")
  tags     = module.ctags.common_tags
}

