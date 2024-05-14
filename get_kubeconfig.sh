#!/bin/bash
# Usage: ./get_kubeconfig.sh <remote_ip>

REMOTE_IP=$(terraform output -raw k3s_server_node_ip)
KUBECONFIG_PATH=kubeconfig.secret.yaml

# Copy kubeconfig from remote server
scp -o StrictHostKeyChecking=no root@"$REMOTE_IP":/etc/rancher/k3s/k3s.yaml $KUBECONFIG_PATH 

# Replace localhost with remote IP
yq eval ".clusters[].cluster.server = \"https://${REMOTE_IP}:6443\"" -i $KUBECONFIG_PATH 
# Replace cluster name with k3s_dev_cluster in clusters and contexts
yq eval ".clusters[].name = \"k3s_dev_cluster\"" -i $KUBECONFIG_PATH
yq eval ".contexts[].context.cluster = \"k3s_dev_cluster\"" -i $KUBECONFIG_PATH
# Replace user name with k3s_dev_webstra in users and contexts
yq eval ".users[].name = \"k3s_dev_webstra\"" -i $KUBECONFIG_PATH
yq eval ".contexts[].context.user = \"k3s_dev_webstra\"" -i $KUBECONFIG_PATH
# Replace context name with k3s_dev_cluster
yq eval ".contexts[].name = \"k3s_dev_cluster\"" -i $KUBECONFIG_PATH
# Replace current context with k3s_dev_cluster
yq eval ".current-context = \"k3s_dev_cluster\"" -i $KUBECONFIG_PATH

kubectl konfig import -s $KUBECONFIG_PATH