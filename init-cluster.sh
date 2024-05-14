terraform apply -auto-approve
echo "waiting 60 seconds for cluster to be ready..."
sleep 60 && ./get-kubeconfig.sh
