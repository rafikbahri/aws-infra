resource "local_file" "ssh_config" {
  filename        = ".ssh/config"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed

# Bastion Host
Host       ${module.bastions.hostnames[0]}
  HostName   ${module.bastions.public_ip[0]}
  IdentityFile ${module.bastions.identity_file}
  User ec2-user
  StrictHostKeyChecking no

# Etcd Instances
%{for node in [module.etcd-cluster]}
%{for hostname, ip in zipmap(node.hostnames, node.private_ips)}
Host       ${hostname}
HostName   ${ip}
%{endfor}
%{endfor}
EOT
}
