resource "aws_lightsail_key_pair" "lg_key_pair" {
  name = "lg_key_pair"
}

resource "aws_lightsail_static_ip_attachment" "attachment" {
  static_ip_name = aws_lightsail_static_ip.ip.id
  instance_name  = aws_lightsail_instance.instance.id
}

resource "random_integer" "id" {
  min = 1
  max = 1000
}

resource "aws_lightsail_static_ip" "ip" {
  name = "StaticIP-${random_integer.id}"
}


resource "aws_lightsail_instance" "instance" {
  name              = var.instance_name
  availability_zone = var.available_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = aws_lightsail_key_pair.lg_key_pair.name
  tags = {
    resource = "xray"
  }
}