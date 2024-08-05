module "etcd-private-subnet" {
  source                  = "./modules/aws-subnet"
  name                    = "etcd-private-subnet"
  vpc_id                  = module.main-vpc.vpc_id
  availability_zone       = "eu-west-3a"
  cidr_block              = "192.168.16.0/24"
  map_public_ip_on_launch = false
  tags = {
    kind  = "private"
    group = "etcd"
  }
}

module "etcd-cluster" {
  source        = "./modules/aws-node"
  server_count  = 3
  server_prefix = "etcd"
  ami_id        = "ami-0546127e0cf2c6498"
  instance_type = "t2.micro"
  vpc_id        = module.main-vpc.vpc_id
  subnet_id     = module.etcd-private-subnet.subnet_id
  create_key    = false
  tags = {
    component = "etcd"
    tier      = "infra"
  }
}
