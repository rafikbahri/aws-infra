resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_internet_gateway" "gtw" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%s-igw", var.name)
    },
    var.tags
  )
}