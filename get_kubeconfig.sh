#!/bin/bash
# Usage: ./get_kubeconfig.sh <remote_ip> <new_kubeconfig_path> <existing_kubeconfig_path>

REMOTE_IP=$1

# Copy kubeconfig from remote server
scp -o StrictHostKeyChecking=no root@"$REMOTE_IP":/etc/rancher/k3s/k3s.yaml kubeconfig.secret.yaml 