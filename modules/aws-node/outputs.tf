output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.instance.*.id
}

output "hostnames" {
  value       = aws_instance.instance.*.tags.Name
  description = "List of hostnames (one per instance)"
}

output "public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = aws_instance.instance.*.public_ip
}

output "private_ips" {
  description = "List of private/internal IPs"
  value       = aws_instance.instance.*.private_ip
}

output "private_key" {
  value     = var.create_key ? tls_private_key.tls-private-key[0].private_key_pem : null
  sensitive = true
}

output "identity_file" {
  value     = var.create_key ? local_file.ssh-key[0].filename : null
  sensitive = true
}