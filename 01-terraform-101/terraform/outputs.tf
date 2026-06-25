output "docker_node_admin_login" {
    value       = local.docker_node_admin_login
    sensitive   = true
    description = "Admin login"
}

output "mysql_root_password" {
    value       = random_password.mysql_root.result
    sensitive   = true
    description = "MySQL root password"
}

output "mysql_user_password" {
    value       = random_password.mysql_root.result
    sensitive   = true
    description = "MySQL user password"
}
