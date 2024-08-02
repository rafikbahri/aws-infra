resource "local_file" "inventory" {
  filename        = "inventory/${var.environment}"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed
[all]
[bastions]
${module.bastions.hostnames[0]}
EOT
}
