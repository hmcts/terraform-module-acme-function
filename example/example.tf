module "acmetags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = "sbox"
  product     = "acme"
  builtFrom   = "terraform-module-acme-function"
}

module "acme" {
  source = "git::https://github.com/hmcts/terraform-module-acme-function.git?ref=master"
  providers = {
    azurerm.dnszone = azurerm.dnszones
  }
  location                 = "uk south"
  env                      = "sbox"
  common_tags              = module.acmetags.common_tags
  product                  = "cftacme" //"sdsacme"
  dns_contributor_group_id = "6307b856-d312-49e2-9944-fbe80dc60b95"
}