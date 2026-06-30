variable "env_name" {
  type        = string
  sensitive   = false
  description = "Name of the environment (will be used as prefix for resource names)"
}

variable "subnets" {
  type = list(
    object({
      zone = string
      cidr = string
    })
  )
  sensitive   = false
  description = "Subnets"
}