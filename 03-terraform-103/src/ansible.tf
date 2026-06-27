resource "local_file" "inventory" {
  filename = "${path.root}/inventory.ini"

  content = templatefile(local.inventory_template, {
    webservers     = yandex_compute_instance.count_vm
    dbservers      = values(yandex_compute_instance.for_each_vm)
    storageservers = [yandex_compute_instance.storage]
  })
}