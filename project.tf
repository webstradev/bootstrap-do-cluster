resource "digitalocean_project" "k3s_cluster" {
  name        = "k3s-dev-cluster"
  description = "k3s Cluster"
  purpose     = "K3s (Kubernetes) Cluster"
  environment = "Development"
}