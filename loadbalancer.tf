# resource "digitalocean_loadbalancer" "k3s_lb" {
#   name   = "k3s-lb"
#   region = var.region

#   forwarding_rule {
#     entry_port     = 80
#     entry_protocol = "http"
#     target_port    = 80
#     target_protocol = "http"
#   }

#   forwarding_rule {
#     entry_port     = 443
#     entry_protocol = "https"
#     target_port    = 80
#     target_protocol = "http"
#     tls_passthrough = true
#   }

#   healthcheck {
#     port = 80
#     protocol = "http"
#     path = "/healthz"
#   }

#   droplet_ids = digitalocean_droplet.k3s_node.*.id
# }

# resource "digitalocean_domain" "domain" {
#   name = var.domain_name
# }

# resource "digitalocean_record" "a_record" {
#   domain = digitalocean_domain.domain.name
#   type   = "A"
#   name   = "@"
#   value  = digitalocean_loadbalancer.k3s_lb.ip
# }

# resource "digitalocean_record" "cname_record" {
#   domain = digitalocean_domain.domain.name
#   type   = "CNAME"
#   name   = "www"
#   value  = digitalocean_domain.domain.name
# }