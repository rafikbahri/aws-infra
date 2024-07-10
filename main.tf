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
}

module "ec2-internal-cluster" {
  source        = "./modules/aws-node"
  server_count  = var.server_count
  server_prefix = var.server_prefix
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.internal-subnet.subnet_id
  tags = {
    purpose   = "test"
    action    = "deleteme"
    schedule  = "after interviews"
    component = "argocd"
  }
}
