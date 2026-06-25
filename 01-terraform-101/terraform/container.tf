resource "time_sleep" "wait_for_ssh" {
    depends_on = [ 
        yandex_compute_instance.docker_node
    ]

    create_duration = "1m"
}

resource "docker_image" "mysql" {
    depends_on = [
        time_sleep.wait_for_ssh
    ]

    name = local.mysql_docker_image
    keep_locally = true
}

resource "docker_container" "mysql" {
    depends_on = [
        docker_image.mysql
    ]

    name = "mysql"
    image = docker_image.mysql.image_id

    env = [
        "MYSQL_ROOT_PASSWORD=${random_password.mysql_root.result}",
        "MYSQL_DATABASE=${local.mysql_database_name}",
        "MYSQL_USER=${local.mysql_user_name}",
        "MYSQL_PASSWORD=${random_password.mysql_user.result}",
        "MYSQL_ROOT_HOST=%"
    ]

    ports {
      protocol  = "tcp"
      ip        = "127.0.0.1"
      internal  = 3306
      external  = 3306
    }
}
