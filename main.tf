provider "aws" {
  region = "eu-west-3"
}

module "sg-admin" {
  source      = "./modules/aws-sg"
  name        = "sg_admin"
  description = "Admin security group"
  vpc_id      = module.main-vpc.vpc_id
  ingress_rules = [
    {
      description = "SSH only from admin IP addresses."
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["88.178.215.32/32"] # SSH only from my public internet IP
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress_rules = [
    {
      description      = "Outbound to respond to SSH."
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

module "main-vpc" {
  source               = "./modules/aws-vpc"
  name                 = "main-vpc"
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  create_igw           = true
  tags = {
    vpc = "main"
  }
}

module "internal-subnet" {
  source                  = "./modules/aws-subnet"
  name                    = "internal-subnet"
  vpc_id                  = module.main-vpc.vpc_id
  availability_zone       = "eu-west-3a"
  cidr_block              = "192.168.171.0/24"
  map_public_ip_on_launch = true
  default_route_table_id  = module.main-vpc.route_table_id
}

module "ec2-internal-cluster" {
  source          = "./modules/aws-node"
  server_count    = var.server_count
  server_prefix   = var.server_prefix
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  vpc_id          = module.main-vpc.vpc_id
  subnet_id       = module.internal-subnet.subnet_id
  security_groups = [module.sg-admin.sg_id]
  tags = {
    purpose   = "test"
    action    = "deleteme"
    schedule  = "after interviews"
    component = "argocd"
  }
}
