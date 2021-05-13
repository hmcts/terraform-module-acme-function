locals {
  private_dns_mapping = {
    sbox = {
      dns_zone       = "sandbox.platform.hmcts.net"
      resource_group = "core-infra-intsvc-rg"
    }
  }
} //endoflocal