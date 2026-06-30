module "vpc" {
  source                = "./modules/vpc"
  env_name              = var.env_name
  subnet_v4_cidr_blocks = local.default.network.subnet.v4_cidr_blocks
  zone                  = local.default.zone
}


# Task04

module "vpc_task04" {
  source       = "./modules/vpc_task04"
  env_name     = var.env_name
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.10.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.20.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.30.0/24" },
  ]
}