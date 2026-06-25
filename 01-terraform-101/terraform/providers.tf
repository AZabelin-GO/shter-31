provider "yandex" {
  token                    = var.cloud_token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_id
}

provider "docker" {
  host      = "ssh://${local.docker_node_admin_login}@${var.public_ip}"
  ssh_opts  = [
    "-o", "StrictHostKeyChecking=no",
    "-o", "UserKnownHostsFile=/dev/null"
  ]
}