# First VM variables
variable "vm_web_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instance name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Instance platform id"
}

# Second VM variables

variable "vm_db_subnet_name" {
  type        = string
  default     = "nt-devops-db"
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_instance_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Instance name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Instance platform id"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Availability zone"
}