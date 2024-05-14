terraform apply -destroy -auto-approve
kubectl config delete-context k3s_dev_cluster
kubectl config delete-cluster k3s_dev_cluster
kubectl config delete-user k3s_dev_webstra 
rm *.secret.yaml