output "public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = module.bastions.public_ip
}

output "bastions_private_ips" {
  value = module.bastions.private_ips
}

output "etcd_private_ips" {
  value = module.etcd-cluster.private_ips
}

output "private_key" {
  value     = var.create_key ? module.bastions.private_key : null
  sensitive = true
}

output "aws_ami_thehive" {
  value       = data.aws_ami.marketplace_ami.id
  description = "The ID of the latest TheHive AMI from AWS Marketplace"
}