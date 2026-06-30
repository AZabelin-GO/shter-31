variable "name" {
  type        = string
  sensitive   = false
  description = "Name of the MySQL cluster"
}

variable "ha" {
  type        = bool
  default     = false
  description = "HA mode"
}
