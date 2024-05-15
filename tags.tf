# Server tag
resource "digitalocean_tag" "server" {
  name = "k3s-server"
}

resource "digitalocean_tag" "node" {
  name = "k3s-node"
}