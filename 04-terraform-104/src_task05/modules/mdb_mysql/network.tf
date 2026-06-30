resource "yandex_vpc_network" "this" {
  name = var.name
}

resource "yandex_vpc_subnet" "this" {
  for_each = { for subnet in local.subnets_selected : subnet.zone => subnet }

  name           = "${var.name}-${each.key}"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = each.value.zone
}