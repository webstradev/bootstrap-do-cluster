#!/bin/bash

# Install k3s server
curl -sfL https://get.k3s.io | K3S_TOKEN=${k3s_token} sh -s - \
    --tls-san ${k3s_lb_ip}

# Confirms the server is running
k3s kubectl get node

# Adjust the kubeconfig permissions for easy retrieval
chmod 644 /etc/rancher/k3s/k3s.yaml