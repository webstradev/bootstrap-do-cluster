#!/bin/bash

# Install k3s server
curl -sfL https://get.k3s.io | K3S_TOKEN="${k3s_token}" sh - \
  --tls-san ${k3s_lb_ip}

# Adjust the kubeconfig permissions for easy retrieval
chmod 644 /etc/rancher/k3s/k3s.yaml