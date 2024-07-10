provider "aws" {
  region = "eu-west-3" 
}

module "ec2-internal-cluster" {
  source        = "./modules/aws-node"
  server_count  = var.server_count
  server_prefix = var.server_prefix
  ami_id        = var.ami_id
  instance_type = var.instance_type
  has_public_ip = false
  tags          = {
    purpose     = "test"
    action      = "deleteme"
    schedule    = "after interviews"
  }
}
