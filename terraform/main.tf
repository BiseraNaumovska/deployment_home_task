terraform {
  required_version = ">= 1.0.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "ubuntu_server" {
  name         = "ubuntu:22.04"
  keep_locally = true
}

resource "docker_network" "vps_network" {
  name = "devops_vps_network"
}

# VPS server with ports : 22, 80, 443, 3000, 9090
resource "docker_container" "devops_vps" {
  name  = "DevOps-HomeTask-VPS"
  image = docker_image.ubuntu_server.image_id

  env = [
    "SSH_PUBLIC_KEY=${trimspace(file(pathexpand("~/.ssh/id_rsa.pub")))}"
  ]

  # SSH Port
  ports {
    internal = 22
    external = 22223
  }

  # HTTP port
  ports {
    internal = 80
    external = 8082
  }

  # HTTPS port
  ports {
    internal = 443
    external = 8444
  }

  # Grafana port
  ports {
    internal = 3000
    external = 3002
  }

  # Prometheus port
  ports {
    internal = 9090
    external = 9092
  }

  networks_advanced {
    name = docker_network.vps_network.name
  }

  # Initial server setup script
  command = ["/bin/bash", "-c", "apt-get update && apt-get install -y openssh-server curl && mkdir -p /run/sshd /root/.ssh && printf '%s\n' \"$SSH_PUBLIC_KEY\" > /root/.ssh/authorized_keys && chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && /usr/sbin/sshd -D"]
}

output "vps_container_name" {
  value       = docker_container.devops_vps.name
  description = "Name of the provisioned VPS server"
}

output "vps_status" {
  value       = "VPS Server successfully provisioned locally via Terraform"
  description = "Infrastructure status"
}