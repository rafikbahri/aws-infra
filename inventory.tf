resource "local_file" "inventory" {
  filename        = "inventory/${var.platform}"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed
[all]
[bastions]
%{for index in range(length(module.bastions.hostnames))~}
${element(module.bastions.hostnames, index)}
%{endfor~}

[etcd]
%{for index in range(length(module.etcd-cluster.hostnames))~}
${element(module.etcd-cluster.hostnames, index)}
%{endfor~}
EOT
}
