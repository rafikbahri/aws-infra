resource "tls_private_key" "tls-private-key" {
  count     = var.create_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key-pair" {
  count      = var.create_key ? 1 : 0
  key_name   = var.key_name
  public_key = tls_private_key.tls-private-key[0].public_key_openssh
}

resource "aws_network_interface" "interface" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
  security_groups = var.security_groups
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "instance" {
  count         = var.server_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.create_key ? aws_key_pair.key-pair[0].key_name : null
  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }
  tags = merge(
    {
      Name = format("%s-00%d", var.server_prefix, count.index + 1)
    },
    var.tags
  )
}

resource "local_file" "ssh_key" {
  count           = var.create_key ? 1 : 0
  content         = tls_private_key.tls-private-key[0].private_key_pem
  filename        = ".ssh/bastion.pem"
  file_permission = "0600"
}

resource "local_file" "ssh_config" {
  content = templatefile("${path.module}/ssh_config.tpl", {
    ip          = tostring(aws_instance.instance[0].public_ip)
    user        = "ec2-user"
    private_key = var.create_key ? ".ssh/bastion.pem" : ""
    hostname    = tostring(aws_instance.instance[0].tags.Name)
  })
  filename = ".ssh/config"
}
