locals {
  default = {
    zone = "ru-central1-a"

    network = {
      subnet = {
        v4_cidr_blocks = ["10.0.1.0/24"]
      }
    }

    instance = {
      platform_id = "standard-v3"

      image_family = "ubuntu-2404-lts"

      resource = {
        cores         = 2
        memory        = 1
        core_fraction = 20
        disk_size     = 10
        disk_type     = "network-hdd"
      }
    }
  }

  cloud_init_config = templatefile("${path.root}/templates/cloud-init.tftpl.yaml", {
    admin_ssh_login       = var.admin_ssh_login
    admin_ssh_public_keys = var.admin_ssh_public_keys
    os_packages           = var.os_packages
  })
}