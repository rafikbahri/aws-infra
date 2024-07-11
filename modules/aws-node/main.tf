resource "aws_security_group" "ssh_sg" {
  count       = var.ssh_enabled ? 1 : 0
  name        = "ssh_security_group"
  description = "Security group for SSH access"
  vpc_id      = var.vpc_id
  ingress {
    description = "SSH from everywhere (dangerous), changes need to be made."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["88.178.215.32/32"] # SSH only from my public internet IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh_security_group"
  }
}

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
  private_ips     = ["192.168.171.31"]
  security_groups = [aws_security_group.ssh_sg[0].id]
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
  filename        = ".ssh/ec2.pem"
  file_permission = "0600"
}

resource "local_file" "ssh_config" {
  content = templatefile("${path.module}/ssh_config.tpl", {
    hostname    = tostring(aws_instance.instance[0].public_ip)
    user        = "ec2-user"
    private_key = var.create_key ? ".ssh/ec2.pem" : ""
  })
  filename = ".ssh/config"
}
