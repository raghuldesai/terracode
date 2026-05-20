#!/bin/bash
set -e

# Update and install dependencies
apt-get update -y
apt-get install -y curl apt-transport-https gnupg

# Install k3s (latest stable)
curl -sfL https://get.k3s.io | sh -

# Install kubectl (latest stable)
curl -LO https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Configure kubeconfig for ubuntu user
mkdir -p /home/ubuntu/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/config
