resource "aws_network_interface" "interface" {
  subnet_id   = var.subnet_id
  private_ips = ["192.168.171.31"]
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "instance" {
  count         = var.server_count
  ami           = var.ami_id
  instance_type = var.instance_type
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