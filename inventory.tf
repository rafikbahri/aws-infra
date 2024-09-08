resource "local_file" "inventory" {
  filename        = "inventory/${var.platform}"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed
[${var.platform}:children]
bastions
etcd

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

resource "local_file" "etchosts" {
  filename        = "inventory/group_vars/${var.platform}/hosts.yml"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed
---
etc_hosts:
%{for index in range(length(module.bastions.hostnames))~}
  - ip: ${element(module.bastions.private_ips, index)}
    names:
      - ${element(module.bastions.hostnames, index)}
      - ${element(module.bastions.hostnames, index)}.${var.platform}
%{endfor~}
%{for index in range(length(module.etcd-cluster.hostnames))~}
  - ip: ${element(module.etcd-cluster.private_ips, index)}
    names:
      - ${element(module.etcd-cluster.hostnames, index)}
      - ${element(module.etcd-cluster.hostnames, index)}.${var.platform}
%{endfor~}
EOT
}
