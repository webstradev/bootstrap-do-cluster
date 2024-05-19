resource "digitalocean_domain" "cluster_domain" {
  name       = "cluster.webstra.dev"
}

# add domain to project
resource "digitalocean_project_resources" "project_cluster_domain"{
  project = digitalocean_project.k3s_cluster.id
  resources = [
    digitalocean_domain.cluster_domain.urn 
  ]
}