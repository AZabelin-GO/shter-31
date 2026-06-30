
resource "yandex_mdb_mysql_cluster" "this" {
  name        = var.name
  environment = local.default.mdb_mysql.environment
  version     = local.default.mdb_mysql.version

  network_id = yandex_vpc_network.this.id

  resources {
    resource_preset_id = local.default.mdb_mysql.resources.resource_preset_id
    disk_type_id       = local.default.mdb_mysql.resources.disk_type_id
    disk_size          = local.default.mdb_mysql.resources.disk_size
  }

  dynamic "host" {
    for_each = yandex_vpc_subnet.this
    content {
      zone             = host.value.zone
      subnet_id        = host.value.id
      assign_public_ip = local.default.mdb_mysql.host.assign_public_ip
    }
  }

  access {
    web_sql = local.default.mdb_mysql.access.web_sql
  }
}