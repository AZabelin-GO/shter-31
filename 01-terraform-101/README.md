# Lesson 01 - Terraform basics

## Preconditions

```sh
azabelin@ess-fearless shter-31 % terraform --version
Terraform v1.15.6
on darwin_arm64
azabelin@ess-fearless shter-31 % tofu --version
OpenTofu v1.12.2
on darwin_arm64
azabelin@ess-fearless shter-31 % 
```

## Task 01

1. No action needed
2. File with personal sensitive data:

    ```sh
    azabelin@ess-fearless 01-terraform-101 % cat src/.gitignore | grep -i tfvars
    personal.auto.tfvars              <===== This file
    ```

3. Script:

    ```sh
    azabelin@ess-fearless src % cat terraform.tfstate| jq '.resources[] | select(.type == "random_password" and .name == "random_string") | .instances[0].attributes.result'
    "vsGXkCK4uKmM36mD"
    azabelin@ess-fearless src % 
    ```

4. Errors: incorrect syntax + incorrect variables references. Fixed code:

    ```hcl
    resource "docker_image" "nginx" { # Fixed error: not enough arguments
        name         = "nginx:latest"
        keep_locally = true
    }

    resource "docker_container" "nginx" { # Fixed error: typo
        image = docker_image.nginx.image_id # Fixed error: not defined variable
        name  = "example_${random_password.random_string.result}" # Fixed error: typo/not existed variable

        ports {
            internal = 80
            external = 9090
        }
    }
    ```

5. Script:

    ```sh
    azabelin@ess-fearless src % tf validate
    Success! The configuration is valid.
    azabelin@ess-fearless src % docker ps -a
    CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
    d27ccce82c7f   ec4ed8b5299e   "/docker-entrypoint.…"   17 minutes ago   Up 17 minutes   0.0.0.0:9090->80/tcp   example_WnLWGweUCs2U9SUI
    azabelin@ess-fearless src % docker image ls
    IMAGE          ID             DISK USAGE   CONTENT SIZE   EXTRA
    nginx:latest   ec4ed8b5299e        259MB         64.3MB    U   
    azabelin@ess-fearless src % 
    ```

6. Option `-auto-approve` is for CI/CD pipelines, but it can be used with command `terraform plan` to review real changes that will be made in pipeline before command `terraform apply -auto-approve`. Script:

    ```sh
    Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
    azabelin@ess-fearless src % docker ps -a          
    CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
    e2f97ed911e2   ec4ed8b5299e   "/docker-entrypoint.…"   4 seconds ago   Up 3 seconds   0.0.0.0:9090->80/tcp   hello_world
    ```

7. Script:

    ```sh
    Destroy complete! Resources: 3 destroyed.
    azabelin@ess-fearless src % docker ps -a
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
    azabelin@ess-fearless src % docker image ls
    IMAGE          ID             DISK USAGE   CONTENT SIZE   EXTRA
    nginx:latest   ec4ed8b5299e        259MB         64.3MB        
    azabelin@ess-fearless src % cat terraform.tfstate
    {
    "version": 4,
    "terraform_version": "1.15.6",
    "serial": 32,
    "lineage": "c32d1aa9-4577-6fca-0852-9d8e3ba8b1cf",
    "outputs": {},
    "resources": [],
    "check_results": null
    }
    azabelin@ess-fearless src %
    ```

8. Root cause: `keep_locally = true`. From docs:
    * `force_remove` (Boolean) If true, then the image is removed forcibly when the resource is destroyed.
        * https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image#force_remove-1
    * `keep_locally` (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
        * https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image#keep_locally-1

## Task 02

1. Dirs:
    * `packer` - create instance image with preinstalled docker
    * `terraform` - terraform/opentofu scripts for instance/container deployment using custom image with preinstalled docker
2. No action needed
3. Docs: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs#remote-hosts
4. Code `terraform/container.tf`:

    ```hcl
    resource "time_sleep" "wait_for_ssh" {
        depends_on = [ 
            yandex_compute_instance.docker_node
        ]

        create_duration = "1m"
    }

    resource "docker_image" "mysql" {
        depends_on = [
            time_sleep.wait_for_ssh
        ]

        name = local.mysql_docker_image
        keep_locally = true
    }

    resource "docker_container" "mysql" {
        depends_on = [
            docker_image.mysql
        ]

        name = "mysql"
        image = docker_image.mysql.image_id

        env = [
            "MYSQL_ROOT_PASSWORD=${random_password.mysql_root.result}",
            "MYSQL_DATABASE=${local.mysql_database_name}",
            "MYSQL_USER=${local.mysql_user_name}",
            "MYSQL_PASSWORD=${random_password.mysql_user.result}",
            "MYSQL_ROOT_HOST=%"
        ]

        ports {
        protocol  = "tcp"
        ip        = "127.0.0.1"
        internal  = 3306
        external  = 3306
        }
    }
    ```

5. Script:

    ```sh
    Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

    Outputs:

    docker_node_admin_login = <sensitive>
    mysql_root_password = <sensitive>
    mysql_user_password = <sensitive>
    azabelin@ess-fearless terraform % ssh tofu@89.169.152.60 'docker exec mysql env'
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    HOSTNAME=40f8d4f30974
    MYSQL_ROOT_HOST=%
    MYSQL_PASSWORD=x90$<OSv
    MYSQL_ROOT_PASSWORD=54QXzb{+
    MYSQL_DATABASE=wordpress
    MYSQL_USER=wordpress
    GOSU_VERSION=1.19
    MYSQL_MAJOR=8.4
    MYSQL_VERSION=8.4.10-1.el9
    MYSQL_SHELL_VERSION=8.4.10-1.el9
    HOME=/root
    azabelin@ess-fearless terraform % ssh tofu@89.169.152.60 'docker ps -a'         
    CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                 NAMES
    40f8d4f30974   d36d39a64cd1   "docker-entrypoint.s…"   41 seconds ago   Up 40 seconds   127.0.0.1:3306->3306/tcp, 33060/tcp   mysql
    azabelin@ess-fearless terraform % 
    ```

## Task 03

* Script:

    ```sh
    azabelin@ess-fearless terraform % tf --version
    Terraform v1.15.6
    on darwin_arm64
    + provider registry.opentofu.org/hashicorp/random v3.9.0
    + provider registry.terraform.io/hashicorp/time v0.14.0
    + provider registry.terraform.io/kreuzwerker/docker v4.5.0
    + provider registry.terraform.io/yandex-cloud/yandex v0.209.0
    azabelin@ess-fearless terraform % tofu --version
    OpenTofu v1.12.2
    on darwin_arm64
    + provider registry.opentofu.org/hashicorp/random v3.9.0
    + provider registry.terraform.io/hashicorp/time v0.14.0
    + provider registry.terraform.io/kreuzwerker/docker v4.5.0
    + provider registry.terraform.io/yandex-cloud/yandex v0.209.0
    azabelin@ess-fearless terraform % tofu validate
    Success! The configuration is valid.
    azabelin@ess-fearless terraform %
    ```
