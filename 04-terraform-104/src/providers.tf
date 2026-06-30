provider "yandex" {
  token     = var.api_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = local.default.zone
}