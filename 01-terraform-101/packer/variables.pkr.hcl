variable "cloud_token" {
    type        = string
    sensitive   = true
    description = "Token for access to cloud provider"
}

variable "folder_id" {
    type        = string
    sensitive   = false
    description = "ID of the folder in CLoud where image will be created"
}

variable "availability_zone" {
    type        = string
    sensitive   = false
    default     = "ru-central1-a"
    description = "Availability zone where image builder VM will be deployed"
}

variable "subnet_id" {
    type    = string
    sensitive   = false
    description = "ID of the subnet in folder that will be used by image builder VM"
}
