resource "digitalocean_droplet" "k3s_server_node" {
  image  = "ubuntu-24-04-x64"
  name   = "k3s-server-node"
  region = var.region
  vpc_uuid = digitalocean_vpc.webstradev_vpc.id
  size   = var.node_size 
  ssh_keys = [
    var.ssh_fingerprint
  ]

  tags = [digitalocean_tag.node.name, digitalocean_tag.server.name]

  user_data = templatefile("${path.module}/install-k3s-server.sh", {})

}

resource "digitalocean_project_resources" "k3s_server_nodes" {
  project = digitalocean_project.k3s_cluster.id
  resources = [
    digitalocean_droplet.k3s_server_node.urn,
  ]
}

output "k3s_server_node_ip" {
  value       = digitalocean_droplet.k3s_server_node.ipv4_address
  description = "The IP address of the k3s server node"
}