locals {
  name_prefix          = "my-prefix"
  vm_web_instance_name = "${local.name_prefix}-${var.vm_web_instance_name}"
  vm_db_instance_name  = "${local.name_prefix}-${var.vm_db_instance_name}"

  vms_metadata = {
    serial-port-enable = 1
    ssh-keys           = sensitive("ubuntu:${var.vms_ssh_root_key}")
  }
}
