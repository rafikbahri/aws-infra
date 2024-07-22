output "group_name" {
  description = "The name of the IAM group"
  value       = aws_iam_group.group.name
}

output "group_arn" {
  description = "The ARN assigned by AWS for this group"
  value       = aws_iam_group.group.arn
}