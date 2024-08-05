resource "local_file" "inventory" {
  filename        = "inventory/${var.platform}"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed
[all]
[bastions]
${module.bastions.hostnames[0]}

[etcd]
%{for index in range(length(module.etcd-cluster.hostnames))~}
${element(module.etcd-cluster.hostnames, index)}
%{endfor~}
EOT
}
