provider "aws" {
  region = "eu-west-3"
}

module "main-vpc" {
  source               = "github.com/rafikbahri/tf-aws-vpc"
  name                 = var.vpc_name
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  create_igw           = true
  tags = {
    vpc = "main"
  }
}

module "sg-admin-bastions" {
  source      = "github.com/rafikbahri/tf-aws-sg"
  name        = "sg_admin_bastions"
  description = "Admin security group"
  vpc_id      = module.main-vpc.vpc_id
  ingress_rules = [
    {
      description = "SSH only from admin IP addresses."
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [
        "88.178.215.32/32" # My public IP address 
      ]
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description = "Ping inside VPC."
      from_port   = 0
      to_port     = 0
      protocol    = "icmp"
      cidr_blocks = ["192.168.0.0/16"]
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress_rules = [
    {
      description      = "Allow all outbound traffic."
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

module "sg-admin" {
  source      = "github.com/rafikbahri/tf-aws-sg"
  name        = "sg_admin"
  description = "Admin security group incoming only from bastions"
  vpc_id      = module.main-vpc.vpc_id
  ingress_rules = [
    {
      description = "SSH using EC2 instance connect (from AWS console)."
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [
        "35.180.112.80/29" # EC2 instance connect service IPs in my region https://ip-ranges.amazonaws.com/ip-ranges.json
      ]
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [module.sg-admin-bastions.sg_id]
      self             = false
    },
    {
      description = "Ping inside VPC."
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["192.168.0.0/16"]
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress_rules = [
    {
      description      = "Allow all outbound traffic."
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
