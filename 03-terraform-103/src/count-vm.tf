resource "yandex_compute_instance" "count_vm" {
  count      = 2
  depends_on = [yandex_compute_instance.for_each_vm]

  name     = "web-${count.index + 1}"
  hostname = "web-${count.index + 1}"

  metadata = local.vms_metadata

  platform_id = local.platform_id
  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 10
      type     = local.vms_disk_type
    }
  }

  network_interface {
    nat       = true
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
}