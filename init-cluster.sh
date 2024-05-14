terraform apply -auto-approve
./get_kubeconfig.sh $(terraform output -raw k3s_node_ip)