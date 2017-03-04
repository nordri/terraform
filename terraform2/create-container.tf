# Configure the Docker provider
provider "docker" {
    host = "tcp://127.0.0.1:2376/"
}

# Create a container
resource "docker_container" "nginx" {
    count = 2
    image = "${docker_image.nginx.latest}"
    name = "nginx-${count.index+1}"
    ports = {
      internal = "80"
    }
    volumes {
      container_path = "/usr/share/nginx/html"
      host_path = "/home/fdiaz/sandbox/terraform2/www"
      read_only = true
    }
}

resource "docker_image" "nginx" {
    name = "nginx:latest"
}

resource "docker_volume" "shared_volume" {
    name = "shared"
}
