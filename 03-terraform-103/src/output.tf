output "inventory" {
  value = concat(local.inventory_count_vm, local.inventory_for_each_vm, local.inventory_storage)
}