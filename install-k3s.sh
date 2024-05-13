#!/bin/bash
curl -sfL https://get.k3s.io | sh -
# Adjust the kubeconfig permissions for easy retrieval
chmod 644 /etc/rancher/k3s/k3s.yaml
