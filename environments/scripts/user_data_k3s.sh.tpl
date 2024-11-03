#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

# Update the package database and install necessary dependencies
apt-get update
apt-get install -y curl coreutils

# Disable swap
swapoff -a

# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh -


# Write K3s configuration to file
sleep 30
mv /etc/rancher/k3s/k3s.yaml /etc/rancher/k3s/k3s.yaml.old
echo "${k3s_config_base64}" | base64 -d | sudo tee /tmp/k3s.yaml
sudo mv /tmp/k3s.yaml /etc/rancher/k3s/k3s.yaml


systemctl restart k3s.service

# Install Helm

curl -fsSL -o /var/tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 /var/tmp/get_helm.sh
. /var/tmp/get_helm.sh

# Enable K3s to start on boot
systemctl enable k3s
