output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.subnet.id
}

output "arn" {
  description = "Subnet ARN"
  value       = aws_subnet.subnet.arn
}

output "cidr_block" {
  description = "Subnet CIDR block"
  value       = aws_subnet.subnet.cidr_block
}