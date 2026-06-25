source "yandex" "docker_node" {
    folder_id           = var.folder_id
    token               = var.cloud_token

    image_name          = local.image_name
    image_family        = local.image_family
    image_description   = local.image_description
    ssh_username        = local.image_ssh_username
    disk_type           = local.image_disk_type
    source_image_family = local.source_image_family
    use_ipv4_nat        = true

    subnet_id           = var.subnet_id
    zone                = var.availability_zone
}

build {
    sources = [
        "source.yandex.docker_node"
    ]

    provisioner "shell" {
        script  = "${path.root}/${local.provisioner_install_docker_script_path}"
    }
}