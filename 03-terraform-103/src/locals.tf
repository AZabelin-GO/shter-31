locals {
  platform_id = "standard-v3"

  vms_image_family = "ubuntu-2404-lts"
  vms_disk_type    = "network-hdd"

  vms_metadata = {
    serial-port-enable = 1
    ssh-keys           = sensitive("ubuntu:${file("~/.ssh/id_rsa.pub")}")
  }

  vm_storage_name = "storage"

  inventory_template = "${path.root}/inventory.tftpl"


  # Task 05
  inventory_count_vm = [
    for x in yandex_compute_instance.count_vm : {
      id   = x.id
      name = x.name
      fqdn = x.fqdn
    }
  ]

  inventory_for_each_vm = [
    for k, v in yandex_compute_instance.for_each_vm : {
      id   = v.id
      name = v.name
      fqdn = v.fqdn
    }
  ]

  inventory_storage = [
    {
      id   = yandex_compute_instance.storage.id
      name = yandex_compute_instance.storage.name
      fqdn = yandex_compute_instance.storage.fqdn
    }
  ]
}