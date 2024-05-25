resource "digitalocean_loadbalancer" "k3s_lb" {
  name     = "k3s-api-loadbalancer"
  region   = var.region
  vpc_uuid = digitalocean_vpc.webstradev_vpc.id

  forwarding_rule {
    tls_passthrough = true
    entry_port      = 6443
    entry_protocol  = "https"

    target_port     = 6443
    target_protocol = "https"
  }

  healthcheck {
    port     = 6443
    protocol = "tcp"
  }

  droplet_tag = digitalocean_tag.server.name
}

resource "digitalocean_project_resources" "k3s_api_server_lb" {
  project = digitalocean_project.k3s_cluster.id
  resources = [
    digitalocean_loadbalancer.k3s_lb.urn
  ]
}