resource "yandex_iam_service_account" "docker_node" {
    name = local.docker_node_service_account_name
}

resource "random_password" "mysql_root" {
    length           = 8
    special          = true
    override_special = "!#$%^&*()-_=+[]{}<>:?" # Excludes /, @, and " which are problematic for MySQL
    min_upper        = 2
    min_lower        = 2
    min_numeric      = 2
    min_special      = 2
}

resource "random_password" "mysql_user" {
    length           = 8
    special          = true
    override_special = "!#$%^&*()-_=+[]{}<>:?" # Excludes /, @, and " which are problematic for MySQL
    min_upper        = 2
    min_lower        = 2
    min_numeric      = 2
    min_special      = 2
}
