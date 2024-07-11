output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.instance.*.id
}

output "public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = aws_instance.instance.*.public_ip
}

output "private_key" {
  value     = var.create_key ? tls_private_key.tls-private-key[0].private_key_pem : null
  sensitive = true
}