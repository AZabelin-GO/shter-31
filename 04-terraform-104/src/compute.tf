module "app-marketing" {
  depends_on = [ module.vpc ]

  source       = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name     = var.env_name
  network_id   = module.vpc.network.id
  subnet_ids   = [module.vpc.subnet.id]
  subnet_zones = [local.default.zone]
  platform     = local.default.instance.platform_id
  preemptible  = true

  instance_name          = "app-marketing"
  instance_count         = 1
  instance_cores         = local.default.instance.resource.cores
  instance_memory        = local.default.instance.resource.memory
  instance_core_fraction = local.default.instance.resource.core_fraction
  boot_disk_size         = local.default.instance.resource.disk_size
  boot_disk_type         = local.default.instance.resource.disk_type

  image_family = local.default.instance.image_family
  public_ip    = true

  metadata = {
    serial-port-enable = 1
    user-data          = local.cloud_init_config
  }

  labels = {
    app = "marketing"
  }
}

module "app-analytics" {
  depends_on = [ module.vpc ]

  source       = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name     = var.env_name
  network_id   = module.vpc.network.id
  subnet_ids   = [module.vpc.subnet.id]
  subnet_zones = [local.default.zone]
  platform     = local.default.instance.platform_id
  preemptible  = true

  instance_name          = "app-analytics"
  instance_count         = 1
  instance_cores         = local.default.instance.resource.cores
  instance_memory        = local.default.instance.resource.memory
  instance_core_fraction = local.default.instance.resource.core_fraction
  boot_disk_size         = local.default.instance.resource.disk_size
  boot_disk_type         = local.default.instance.resource.disk_type

  image_family = local.default.instance.image_family
  public_ip    = true

  metadata = {
    serial-port-enable = 1
    user-data          = local.cloud_init_config
  }

  labels = {
    app = "analytics"
  }
}
