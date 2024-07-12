output "sg_id" {
  description = "ID of the created security groups"
  value       = aws_security_group.sg.id
}
