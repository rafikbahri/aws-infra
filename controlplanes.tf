module "k8s-controlplanes-private-subnet" {
  source                  = "./modules/aws-subnet"
  name                    = "k8s-controlplanes-private"
  vpc_id                  = module.main-vpc.vpc_id
  availability_zone       = "eu-west-3a"
  cidr_block              = "192.168.181.0/24"
  map_public_ip_on_launch = false
  default_route_table_id  = module.main-vpc.route_table_id
}

module "k8s-controlplanes-cluster" {
  source          = "./modules/aws-node"
  server_count    = 3
  server_prefix   = "k8scontrolplane"
  ami_id          = "ami-0546127e0cf2c6498"
  instance_type   = "t2.micro"
  vpc_id          = module.main-vpc.vpc_id
  subnet_id       = module.k8s-controlplanes-private-subnet.subnet_id
  security_groups = [module.sg-admin.sg_id]
  tags = {
    component = "controlplane"
    tier      = "infra"
  }
}
