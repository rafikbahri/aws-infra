output "access_key_id" {
  value = module.github-actions-user.access_key_id
}

output "secret_access_key" {
  value     = module.github-actions-user.secret_access_key
  sensitive = true
}