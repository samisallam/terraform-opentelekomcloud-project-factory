resource "opentelekomcloud_vpc_v1" "vpc" {
  name = var.name
  cidr = var.cidr_block
  tags = var.tags

    lifecycle {
    ignore_changes = [
      cidr
    ]
  }

}

resource "opentelekomcloud_vpc_subnet_v1" "subnets" {
  for_each   = var.subnets
  name       = each.key
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = each.value != "" ? each.value : local.subnets_default_cidr[each.key]
  gateway_ip = cidrhost(each.value != "" ? each.value : local.subnets_default_cidr[each.key], 1)
  dns_list   = var.dns_config
  tags       = var.tags

  lifecycle {
    ignore_changes = [
      cidr
    ]
  }

}
