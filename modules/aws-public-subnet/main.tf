resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = var.name,
      kind = "public"
    },
    var.tags
  )
}

resource "aws_route_table_association" "internet" {
  count          = var.has_internet_access ? 1 : 0
  subnet_id      = aws_subnet.subnet.id
  route_table_id = var.public_internet_route_table_id
}