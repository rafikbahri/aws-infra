output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = module.bastions.instance_id
}

output "public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = module.bastions.public_ip
}

output "private_key" {
  value     = var.create_key ? module.bastions.private_key : null
  sensitive = true
}
