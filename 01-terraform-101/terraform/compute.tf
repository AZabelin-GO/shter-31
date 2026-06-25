resource "yandex_compute_instance" "docker_node" {
    count               = 1

    name                = "docker-node-${count.index}"
    hostname            = "docker-node-${count.index}"
    platform_id         = "standard-v3"
    service_account_id  = yandex_iam_service_account.docker_node.id

    metadata = {
        user-data = templatefile("${path.root}/templates/cloud-init-docker-node.tpl.yaml", {
            admin_login         = sensitive(local.docker_node_admin_login)
            public_key_openssh  = sensitive(var.public_ssh_key)
        })
        ssh-keys = sensitive("${local.docker_node_admin_login}:${var.public_ssh_key}")
        serial-port-enable = "1"
    }

    scheduling_policy {
        preemptible = true
    }

    resources {
        cores         = 2
        core_fraction = 20
        memory        = 2
    }

    boot_disk {
        initialize_params {
            name        = "docker-node-${count.index}"
            type        = "network-hdd"
            size        = 10
            image_id    = var.image_id
        }

        auto_delete     = true
    }

    network_interface {
        nat                 = true

        subnet_id           = var.subnet_id

        nat_ip_address      = var.public_ip

        security_group_ids  = [
            var.security_group_id
        ]
    }
}
