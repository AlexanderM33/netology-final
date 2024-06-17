resource "yandex_vpc_network" "diplom_vpc" {
  name = "net-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "subnet" {
  for_each   = var.subnets
  name       = "net_${each.key}_${terraform.workspace}"
  zone       = each.value.zone
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [each.value.cidr_block]
}
