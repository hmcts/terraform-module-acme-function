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
  location    = "uk south"
  env         = "sbox"
  dns_zones   = ["sandbox.platform.hmcts.net"]
  common_tags = module.acmetags.common_tags
  product     = "cftacme" //"sdsacme"
}