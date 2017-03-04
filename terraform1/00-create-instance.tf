# Configure the OpenStack Provider
provider "openstack" {
    user_name   = "demo"
    tenant_name = "demo"
    password    = "d3m0"
    auth_url    = "http://ct-controller:35357/v3"
    domain_name = "Default"
}

##Setup needed variables
variable "node-count" {}
variable "floating-ip-pool" {}
variable "internal-ip-pool" {}
variable "image-name" {}
variable "image-flavor" {}
variable "security-groups" {}
variable "key-pair" {}

##Create a single master node and floating IP
resource "openstack_compute_floatingip_v2" "ip-address" {
  pool = "${var.floating-ip-pool}"
}

resource "openstack_compute_instance_v2" "Server" {
  name = "terraform-test"
  image_id = "${var.image-name}"
  flavor_name = "${var.image-flavor}"
  key_pair = "${var.key-pair}"
  security_groups = ["${split(",", var.security-groups)}"]

  metadata {
    this = "Terraform Rules"
  }

  network {
    name = "${var.internal-ip-pool}"
  }
  floating_ip = "${openstack_compute_floatingip_v2.ip-address.address}"
}

