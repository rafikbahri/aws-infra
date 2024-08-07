provider "aws" {
  region = "eu-west-3"
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