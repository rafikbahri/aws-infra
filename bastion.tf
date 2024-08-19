module "bastions-subnet" {
  source                  = "./modules/aws-subnet"
  name                    = "bastion-subnet"
  vpc_id                  = module.main-vpc.vpc_id
  availability_zone       = "eu-west-3a"
  cidr_block              = "192.168.15.0/24"
  map_public_ip_on_launch = true
  default_route_table_id  = module.main-vpc.route_table_id
  has_internet_access     = true
  tags = {
    kind  = "public"
    group = "bastions"
  }
}

module "bastions" {
  source          = "./modules/aws-node"
  server_count    = var.bastion_servers_count
  server_prefix   = "bastion"
  ami_id          = "ami-0546127e0cf2c6498"
  instance_type   = "t2.micro"
  vpc_id          = module.main-vpc.vpc_id
  subnet_id       = module.bastions-subnet.subnet_id
  private_ips     = ["192.168.15.11"]
  security_groups = [module.sg-admin.sg_id]
  user_data_file  = ".config/cloudinit_user_data.yaml"
  tags = {
    purpose     = "bastion"
    description = "Serves for SSH access"
    component   = "infra"
  }
}
