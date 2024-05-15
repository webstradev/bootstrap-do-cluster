terraform apply -auto-approve
echo "waiting 30 seconds for cluster to be ready..."
sleep 30 && ./get-kubeconfig.sh
