output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = module.ec2-internal-cluster.instance_id
}

output "public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = module.ec2-internal-cluster.public_ip
}

output "private_key" {
  value     = var.create_key ? module.ec2-internal-cluster.private_key : null
  sensitive = true
}
