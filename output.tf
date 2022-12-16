output "instance_instance_summary" {
  value = aws_lightsail_instance.instance
}

output "ssh_to_instance" {
    value = "sudo ssh -i ${local_file.private_key.filename} ${aws_lightsail_instance.instance.username}@${aws_lightsail_static_ip.ip.ip_address}"
}