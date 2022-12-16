output "instance_instance_summary" {
  value = aws_lightsail_instance.instance
}

output "private_key" {
  value     = tls_private_key.ed25519-key.private_key_pem
  sensitive = true
}