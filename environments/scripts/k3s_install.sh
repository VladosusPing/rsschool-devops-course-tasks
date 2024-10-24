#!/bin/bash



# Update the package database and install necessary dependencies
apt-get update
apt-get install -y curl

# Disable swap (Kubernetes requires swap to be disabled)
swapoff -a

# Install K3s using the official K3s install script
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh -

# Install helm using the official helm install script
curl -fsSL -o /var/tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 /var/tmp/get_helm.sh
. /var/tmp/get_helm.sh

# Optional: Enable K3s to start on boot
systemctl enable k3s

# Cleanup
apt-get autoremove -y
apt-get clean

echo "K3s all-in-one cluster installation complete. You can verify with 'kubectl get nodes'."