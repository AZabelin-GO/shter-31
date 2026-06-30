output "cluster" {
  value = {
    id   = yandex_mdb_mysql_cluster.this.id
    name = yandex_mdb_mysql_cluster.this.name
  }
  description = "MySQL cluster"
}
