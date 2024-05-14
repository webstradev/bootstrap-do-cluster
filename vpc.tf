resource "digitalocean_vpc" "webstradev_vpc" {
  name     = "webstradev-vpc"
  region   = var.region
}