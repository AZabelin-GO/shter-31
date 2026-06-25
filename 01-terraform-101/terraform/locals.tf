locals {
    docker_node_service_account_name    = "docker-node"
    docker_node_admin_login             = "tofu"

    mysql_docker_image                  = "mysql:8"
    mysql_user_name                     = "wordpress"
    mysql_database_name                 = "wordpress"
}
