# Server tag
resource "digitalocean_tag" "server" {
  name = "k3s-server"
}

# Agent tag
resource "digitalocean_tag" "agent" {
  name = "k3s-agent"
}

resource "digitalocean_tag" "node" {
  name = "k3s-node"
}