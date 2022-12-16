resource "aws_lightsail_instance" "instance" {
  name              = var.instance_name
  availability_zone = format("%s%s", var.aws_region, "a")
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = aws_lightsail_key_pair.lg_key_pair.name
  tags = {
    resource = "xray"
  }
}

resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_lightsail_key_pair" "lg_key_pair" {
  name = "${lower(var.instance_name)}_lg_key_pair"
  public_key = tls_private_key.rsa-key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.rsa-key.private_key_pem
  filename        = "${lower(var.instance_name)}_pkey.pem"
  file_permission = "0600"
}

resource "random_integer" "id" {
  min = 1
  max = 1000
}

resource "aws_lightsail_static_ip" "ip" {
  name = format("StaticIP-%s",tostring(random_integer.id.result))
}

resource "aws_lightsail_static_ip_attachment" "attachment" {
  static_ip_name = aws_lightsail_static_ip.ip.id
  instance_name  = aws_lightsail_instance.instance.id
}


resource "aws_lightsail_instance_public_ports" "open" {
  instance_name = aws_lightsail_instance.instance.name

  port_info {
    protocol  = "tcp"
    from_port = 0
    to_port   = 65535
  }
}