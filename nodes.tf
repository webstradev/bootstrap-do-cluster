resource "digitalocean_droplet" "k3s_server_node" {
  image  = "ubuntu-24-04-x64"
  name   = "k3s-server-node"
  region = var.region
  vpc_uuid = digitalocean_vpc.webstradev_vpc.id
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    var.ssh_fingerprint
  ]

  tags = [digitalocean_tag.node.name, digitalocean_tag.server.name]

  user_data = templatefile("${path.module}/install-k3s.sh", {
    server_ip = "",
    k3s_token = random_password.k3s_token.result
  })
}

resource "digitalocean_project_resources" "k3s_server_nodes" {
  project = digitalocean_project.k3s_cluster.id
  resources = [
    digitalocean_droplet.k3s_server_node.urn,
  ]
}

resource "digitalocean_droplet" "k3s_agent_node" {
  count = var.node_count - 1
  image  = "ubuntu-24-04-x64"
  name   = "k3s-agent-node-${count.index}"
  region = var.region
  vpc_uuid = digitalocean_vpc.webstradev_vpc.id 
  size   = var.node_size
  ssh_keys = [
    var.ssh_fingerprint
  ]

  tags = [digitalocean_tag.node.name, digitalocean_tag.agent.name]

  user_data = templatefile("${path.module}/install-k3s.sh", {
    server_ip = digitalocean_droplet.k3s_server_node.ipv4_address,
    k3s_token = random_password.k3s_token.result
  })

  depends_on = [digitalocean_droplet.k3s_server_node]
}

resource "digitalocean_project_resources" "k3s_agent_nodes" {
  count   = var.node_count - 1
  project = digitalocean_project.k3s_cluster.id
  resources = [
    digitalocean_droplet.k3s_agent_node[count.index].urn,
  ]
}

output "k3s_server_node_ip" {
  value       = digitalocean_droplet.k3s_server_node.ipv4_address
  description = "The IP address of the k3s server node"
}

output "k3s_agent_node_ips" {
  value       = digitalocean_droplet.k3s_agent_node.*.ipv4_address
  description = "The IP addresses of the k3s agent nodes"
}

output "k3s_api_lb_ip" {
  value       = digitalocean_loadbalancer.k3s_lb.ip
  description = "The IP address of the k3s API load balancer"
}