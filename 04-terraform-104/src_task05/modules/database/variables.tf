variable "cluster_id" {
  type        = string
  sensitive   = false
  description = "Id of the MySQL cluster"
}

variable "db_name" {
  type        = string
  sensitive   = false
  description = "Name of the database"
}

variable "user_name" {
  type        = string
  sensitive   = true
  description = "Name of the user"
}

variable "user_password" {
  type        = string
  sensitive   = true
  description = "Password for the user"
}
