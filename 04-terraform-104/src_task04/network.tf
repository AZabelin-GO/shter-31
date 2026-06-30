# Task04
module "vpc_task04" {
  source   = "./modules/vpc"
  env_name = var.env_name
  subnets  = local.subnets
}