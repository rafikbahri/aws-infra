resource "local_file" "ssh_config" {
  filename        = ".ssh/config"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed

Host                    ${module.bastions.hostnames[0]}
  HostName              ${module.bastions.public_ip[0]}

%{~for node in [module.etcd-cluster]~}
%{~for hostname, ip in zipmap(node.hostnames, node.private_ips)~}
Host                    ${hostname}
  HostName              ${ip}
%{~endfor~}
%{~endfor~}

Host                    * !${module.bastions.hostnames[0]}
  ProxyJump             ${module.bastions.hostnames[0]}

Host                    *
  user                  ${var.ssh_user}
  StrictHostKeyChecking no
  UserKnownHostsFile    /dev/null

EOT
}
