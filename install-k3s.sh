#!/bin/bash

if [ -z "$server_ip" ]; then
  # Install k3s server
  curl -sfL https://get.k3s.io | K3S_TOKEN="${k3s_token}" sh -s - server
  while ! test -d /etc/rancher/k3s/k3s.yaml; do
    echo "Waiting for 'kubeconfig' file to be created at '/etc/rancher/k3s/k3s.yaml"
    sleep 3
  done
  # Adjust the kubeconfig permissions for easy retrieval
  chmod 644 /etc/rancher/k3s/k3s.yaml
else
  # Install k3s agent
  curl -sfL https://get.k3s.io | K3S_URL="https://${server_ip}:6443" K3S_TOKEN="${k3s_token}" sh -s -
fi