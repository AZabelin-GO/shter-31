variable "cloud_token" {
    type        = string
    sensitive   = true
    description = "Token for access to cloud provider"
}

variable "cloud_id" {
    type        = string
    sensitive   = true
    description = "ID of the cloud where node will be deployed"
}

variable "folder_id" {
    type        = string
    sensitive   = true
    description = "ID of the folder in cLoud where node will be deployed"
}

variable "zone_id" {
    type        = string
    sensitive   = false
    default     = "ru-central1-a"
    description = "Availability zone where where node will be deployed"
}

variable "subnet_id" {
    type        = string
    sensitive   = false
    description = "ID of the subnet in folder that will be used by node"
}

variable "public_ip" {
    type = string
    sensitive = false
    description = "Public IPv4 address for node"
}

variable "security_group_id" {
    type = string
    sensitive = false
    description = "ID of the security group that will be used by node"
  
}

variable "image_id" {
    type        = string
    sensitive   = false
    description = "ID of the image from which node will be deployed"
}

variable "public_ssh_key" {
    type = string
    sensitive = true
    description = "Public part of the SSH key"
}
