variable "env_name" {
  type        = string
  sensitive   = false
  description = "Name of the environment (will be used as prefix for resources names)"
}

variable "subnet_v4_cidr_blocks" {
  type        = list(string)
  sensitive   = false
  description = "CIDR blocks for subnet"
}

variable "zone" {
  type        = string
  sensitive   = false
  description = "Availability zone"
}