locals {
  default = {
    subnets = [
      {
        zone           = "ru-central1-a"
        v4_cidr_blocks = ["10.10.1.0/24"]
      },
      {
        zone           = "ru-central1-b"
        v4_cidr_blocks = ["10.10.2.0/24"]
      }
    ]
    mdb_mysql = {
      environment = "PRODUCTION"
      version     = "8.4"
      access = {
        web_sql = true
      }

      resources = {
        resource_preset_id = "c3-c2-m4"
        disk_type_id       = "network-ssd"
        disk_size          = 10
      }

      host = {
        assign_public_ip = false
      }
    }
  }

  subnets_count    = var.ha ? 2 : 1
  subnets_selected = slice(local.default.subnets, 0, local.subnets_count)
}