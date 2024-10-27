resource "local_file" "ssh_config" {
  count           = var.bastion_servers_count
  filename        = ".ssh/config"
  file_permission = "0644"
  content         = <<EOT
# Terraform managed

%{~for node in [module.bastions]~}
%{~for hostname, ip in zipmap(node.hostnames, node.public_ip)}
Host                    ${hostname}
  HostName              ${ip}
%{~endfor~}
%{~endfor~}


%{~for node in [module.etcd-cluster]~}
%{~for hostname, ip in zipmap(node.hostnames, node.private_ips)}
Host                    ${hostname}
  HostName              ${ip}
%{~endfor~}
%{~endfor}

Host                    * !bastion* !${module.bastions.hostnames[0]}
  ProxyJump             ${module.bastions.hostnames[0]}

Host                    *
  user                  ${var.ssh_user}
  StrictHostKeyChecking no
  UserKnownHostsFile    /dev/null

EOT
}
