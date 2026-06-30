resource "yandex_vpc_network" "this" {
  name = "${var.env_name}-network"
}

resource "yandex_vpc_subnet" "this" {
  name           = "${var.env_name}-subnet"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.subnet_v4_cidr_blocks
}
