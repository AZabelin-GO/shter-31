output "network" {
  value = {
    id   = yandex_vpc_network.this.id
    name = yandex_vpc_network.this.name
  }
  description = "Network resource"
}

output "subnet" {
  value = {
    id   = yandex_vpc_subnet.this.id
    name = yandex_vpc_subnet.this.name
  }
  description = "Subnet resource"
}