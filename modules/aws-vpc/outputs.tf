output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = aws_vpc.vpc.arn
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = try(aws_internet_gateway.igw[0].id, "")
}

output "public_internet_route_table_id" {
  description = "ID of the public internet route table"
  value       = aws_route_table.public.id
}
