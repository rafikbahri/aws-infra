resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = merge(
    {
      Name = var.name,
      kind = "private"
    },
    var.tags
  )
}

# Internet for private subnets

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "MainNatGateway"
  }
}

# Route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "PrivateInternetRouteTable"
  }
}

resource "aws_route_table_association" "internet" {
  count          = var.has_internet_access ? 1 : 0
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.private.id
}

