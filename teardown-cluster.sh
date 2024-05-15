terraform destroy -auto-approve
# Need to do it again because the vpc might not have been removed if the 
# previous command tried to destroy it before destroying all droplets.
sleep 2;
terraform destroy -auto-approve
kubectl config delete-context k3s_dev_cluster
kubectl config delete-cluster k3s_dev_cluster
kubectl config delete-user k3s_dev_webstra 
rm *.secret.yaml