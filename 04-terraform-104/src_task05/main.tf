module "mdb_mysql" {
  source = "./modules/mdb_mysql"

  name = var.cluster_name
  ha   = var.ha
}

module "db" {
  source = "./modules/database"

  cluster_id    = module.mdb_mysql.cluster.id
  db_name       = var.db_name
  user_name     = var.user_name
  user_password = var.user_password
}
