resource "digitalocean_droplet" "k3s_node" {
  image  = "ubuntu-24-04-x64"
  name   = "k3s-dev-cluster"
  region = "ams3"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    var.ssh_fingerprint
  ]

  # Remote-exec provisioner to install k3s after the droplet is ready
  provisioner "remote-exec" {
    script = "install-k3s.sh"

    connection {
      type        = "ssh"
      user        = "root"
      host        = self.ipv4_address
      agent       = true
    }
  }
}

output "k3s_node_ip" {
  value = digitalocean_droplet.k3s_node.ipv4_address
  description = "The IP address of the k3s node"
}

variable "ssh_fingerprint" {
  description = "SSH fingerprint of the public key to use for SSH access"
}

variable "private_key_path" {
  description = "Path to the private SSH key"
}