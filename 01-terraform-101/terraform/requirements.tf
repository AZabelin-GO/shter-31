terraform {
    required_providers {
        yandex  = {
            source  = "registry.terraform.io/yandex-cloud/yandex"
            version = ">= 0.127.0"
        }

        docker = {
            source  = "registry.terraform.io/kreuzwerker/docker"
            version = ">= 4.5.0"
        }

        time = {
            source  = "registry.terraform.io/hashicorp/time"
            version = ">= 0.11" 
        }
    }
}
