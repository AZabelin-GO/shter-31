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

# VMs variables
variable "env_name" {
  type        = string
  sensitive   = false
  default     = "dev"
  description = "Name of the environment (used as prefix)"
  validation {
    condition     = contains(["dev", "staging", "production"], var.env_name)
    error_message = "Must be one of: 'dev', 'staging', 'production'"
  }
}

variable "admin_ssh_login" {
  type        = string
  sensitive   = true
  description = "value"
}

variable "admin_ssh_public_keys" {
  type        = list(string)
  sensitive   = true
  description = "List of public parts of SSH keys for admin user"
}

variable "os_packages" {
  type      = list(string)
  sensitive = false
  default = [
    "nginx"
  ]
  description = "List of OS packages to install on instance"
}
