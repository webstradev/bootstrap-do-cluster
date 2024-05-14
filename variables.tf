variable "ssh_fingerprint" {
  description = "SSH fingerprint of the public key to use for SSH access"
}

variable "private_key_path" {
  description = "Path to the private SSH key"
}

variable "node_count"{
  description = "The number of k3s nodes to create"
  default = 3
}

variable "region" {
  description = "The region to deploy the k3s cluster"
  default = "ams3"
}

variable "node_size" {
  description = "The size of the k3s nodes"
  default = "s-1vcpu-1gb"
}

variable "domain_name" {
  description = "The domain name to use for the k3s cluster"
}