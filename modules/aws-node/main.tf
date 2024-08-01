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

resource "local_file" "ssh-key" {
  count           = var.create_key ? 1 : 0
  content         = tls_private_key.tls-private-key[0].private_key_pem
  filename        = ".ssh/${format("%s00%d", var.server_prefix, count.index + 1)}.pem"
  file_permission = "0600"
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
  user_data = base64encode(file("${path.module}/cloudinit_user_data.yaml"))
  tags = merge(
    {
      Name = format("%s00%d", var.server_prefix, count.index + 1)
    },
    var.tags
  )
}
