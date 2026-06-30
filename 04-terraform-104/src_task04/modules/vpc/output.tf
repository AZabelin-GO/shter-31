output "network" {
  value = {
    id   = yandex_vpc_network.this.id
    name = yandex_vpc_network.this.name
  }
  description = "Network resource"
}

output "subnets" {
  value = [
    for subnet in yandex_vpc_subnet.this : {
      id   = subnet.id
      name = subnet.name
    }
  ]
  description = "Subnet resources"
}