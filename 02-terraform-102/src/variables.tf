###cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "nt-devops-xx"
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  description = "Public part of SSH key"
}

# VMs vars

variable "vms_image_family" {
  type        = string
  default     = "ubuntu-2404-lts"
  description = "Image family"
}

variable "vms_resources" {
  type = object({
    web = object({
      cores         = number
      memory        = number
      core_fraction = number
      disk_size     = number
      disk_type     = string
    })
    db = object({
      cores         = number
      memory        = number
      core_fraction = number
      disk_size     = number
      disk_type     = string
    })
  })

  description = "VMs resources"
}

