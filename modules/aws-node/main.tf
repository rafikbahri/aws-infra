resource "aws_instance" "instance" {
  count                       = var.server_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.has_public_ip
  tags                        = merge(
    { 
    Name                      = format("%s-00%d", var.server_prefix, count.index + 1)
    }, 
    var.tags
  )
}