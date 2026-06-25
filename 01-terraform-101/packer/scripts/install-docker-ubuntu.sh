#!/usr/bin/env sh

set -xe

export DEBIAN_FRONTEND=noninteractive

# Wait for Cloud-init
sudo -E cloud-init status --wait

# Add Docker's official GPG key:
sudo -E apt update
sudo -E apt install -y ca-certificates curl
sudo -E install -m 0755 -d /etc/apt/keyrings
sudo -E curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo -E chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo -E tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo -E apt update

sudo -E apt install -y containerd.io docker-ce docker-ce-cli docker-buildx-plugin docker-compose-plugin

# Enable Docker service
sudo -E systemctl enable docker
sudo -E systemctl start docker

# Clean APT cache
sudo -E apt clean
sudo -E rm -rf /var/lib/apt/lists/*

# Reset Machine ID
if [ -f /etc/machine-id ]; then
    sudo -E truncate -s 0 /etc/machine-id
fi
