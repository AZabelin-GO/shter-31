# YC variables
variable "api_token" {
  type        = string
  sensitive   = true
  description = "OAuth token for YC"
}

variable "cloud_id" {
  type        = string
  sensitive   = false
  description = "ID of the cloud in YC"
}

variable "folder_id" {
  type        = string
  sensitive   = false
  description = "ID of the folder in YC"
}

variable "cluster_name" {
  type        = string
  sensitive   = false
  description = "Name of the MySQL cluster"
}

variable "ha" {
  type        = bool
  default     = false
  description = "Deploy resources in HA mode"
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
