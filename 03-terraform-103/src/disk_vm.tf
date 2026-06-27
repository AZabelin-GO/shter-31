resource "yandex_compute_disk" "storage" {
  count = 3

  name = "storage-${count.index}"
  size = 1
  type = local.vms_disk_type
}

resource "yandex_compute_instance" "storage" {
  name     = local.vm_storage_name
  hostname = local.vm_storage_name

  metadata = local.vms_metadata

  platform_id = local.platform_id
  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 10
      type     = local.vms_disk_type
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage
    content {
      disk_id = secondary_disk.value.id
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