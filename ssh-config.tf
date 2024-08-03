resource "local_file" "ssh_config" {
  filename        = ".ssh/config"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed

Host       ${module.bastions.hostnames[0]}
HostName   ${module.bastions.public_ip[0]}
IdentityFile ${module.bastions.identity_file}
User ec2-user
StrictHostKeyChecking no
EOT
}
