
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
