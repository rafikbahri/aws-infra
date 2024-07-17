output "role_arn" {
  value       = aws_iam_role.role.arn
  description = "ARN of the created IAM role"
}

output "role_name" {
  value       = aws_iam_role.role.name
  description = "Name of the created IAM role"
}