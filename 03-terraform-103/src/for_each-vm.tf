resource "yandex_compute_instance" "for_each_vm" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name     = each.value.vm_name
  hostname = each.value.vm_name

  metadata = local.vms_metadata

  platform_id = local.platform_id
  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
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