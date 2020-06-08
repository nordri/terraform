resource "digitalocean_droplet" "server" {
    image = "ubuntu-18-04-x64"
    name = "server"
    region = "fra1"
    size = "s-1vcpu-1gb"
    private_networking = true
    ssh_keys = [
        var.ssh_fingerprint
    ]

    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.pvt_key)
        timeout = "2m"
    }

    provisioner "file" {
        source      = "install-soft.sh"
        destination = "/opt/install-soft.sh"
    }

    provisioner "remote-exec" {
        inline = [
          "chmod +x /opt/install-soft.sh",
          "/opt/install-soft.sh"
        ]
    }
}