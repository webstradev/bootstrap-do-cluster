#!/bin/bash

if [ -z "$server_ip" ]; then
  # Install k3s server
  curl -sfL https://get.k3s.io | K3S_TOKEN="${k3s_token}" sh -
  # Adjust the kubeconfig permissions for easy retrieval
  chmod 644 /etc/rancher/k3s/k3s.yaml
else
  # Install k3s agent
  curl -sfL https://get.k3s.io | K3S_URL="https://${server_ip}:6443" K3S_TOKEN="${k3s_token}" sh -
fi