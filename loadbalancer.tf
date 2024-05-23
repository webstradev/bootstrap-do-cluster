resource "digitalocean_loadbalancer" "k3_lb" {
  name       = "k3s-loadbalancer"
  region     = "ams3"
  droplet_tag = digitalocean_tag.node.name 
  vpc_uuid = digitalocean_vpc.webstradev_vpc.id

  forwarding_rule {
    entry_protocol = "http"
    entry_port     = 80
    target_protocol = "http"
    target_port    = 30080
  }

  forwarding_rule {
    entry_protocol = "https"
    entry_port     = 443
    target_protocol = "https"
    target_port    = 30443
    tls_passthrough = true
  }

  healthcheck {
    port     = 30080
    protocol = "http"
    path     = "/"
    check_interval_seconds = 10
    response_timeout_seconds = 5
    healthy_threshold = 3
    unhealthy_threshold = 3
  }

}

resource "digitalocean_project_resources" "k3s_loadbalancers"{
  project = digitalocean_project.k3s_cluster.id
  resources = [
    digitalocean_loadbalancer.k3_lb.urn 
  ]
}

resource "digitalocean_record" "cluster_domain_a_record" {
  domain = digitalocean_domain.cluster_domain.name
  type   = "A"
  name   = "*"
  value  = digitalocean_loadbalancer.k3_lb.ip
}