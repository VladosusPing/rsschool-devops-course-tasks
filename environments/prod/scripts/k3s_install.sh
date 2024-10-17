#!/bin/bash

# Update the package database and install necessary dependencies
apt-get update
apt-get install -y curl

# Disable swap (Kubernetes requires swap to be disabled)
swapoff -a

# Install K3s using the official K3s install script
curl -sfL https://get.k3s.io | sh -

# Cleanup
apt-get autoremove
apt-get clean