#!/bin/bash

# Install k3s server
curl -sfL https://get.k3s.io | sh -s - --disable traefik --flannel-backend=none --disable-network-policy
# Adjust the kubeconfig permissions for easy retrieval
chmod 644 /etc/rancher/k3s/k3s.yaml