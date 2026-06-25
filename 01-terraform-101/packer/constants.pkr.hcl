locals {
    image_name          = "docker-node-ubuntu2404lts"
    image_family        = "docker-node"
    image_description   = "Docker docker node based on Ubuntu 24.04 LTS"
    image_ssh_username  = "ubuntu"
    image_disk_type     = "network-hdd"
    source_image_family = "ubuntu-2404-lts"

    provisioner_install_docker_script_path  = "scripts/install-docker-ubuntu.sh"
}
