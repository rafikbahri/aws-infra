output "user_name" {
  description = "The name of the IAM user"
  value       = aws_iam_user.user.name
}

output "user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.user.arn
}

output "access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.access_key.id
}

output "secret_access_key" {
  description = "The secret access key. This will be written to the state file in plain-text"
  value       = aws_iam_access_key.access_key.secret
  sensitive   = true
}