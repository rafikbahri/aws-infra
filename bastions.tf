module "bastions-subnet" {
  source                         = "./modules/aws-public-subnet"
  name                           = "bastion-subnet"
  vpc_id                         = module.main-vpc.vpc_id
  availability_zone              = "eu-west-3a"
  cidr_block                     = var.bastions_subnet_cidr
  map_public_ip_on_launch        = true
  public_internet_route_table_id = module.main-vpc.public_internet_route_table_id
  has_internet_access            = true
  tags = {
    group = "bastions"
  }
}

module "bastions" {
  source          = "./modules/aws-node"
  server_count    = var.bastion_servers_count
  server_prefix   = "bastion"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  vpc_id          = module.main-vpc.vpc_id
  subnet_id       = module.bastions-subnet.subnet_id
  private_ips     = [["192.168.15.11"], ["192.168.15.12"], ["192.168.15.13"]]
  create_key      = false
  security_groups = [module.sg-admin-bastions.sg_id, module.sg-admin.sg_id]
  user_data_file  = ".config/cloudinit_user_data.yaml"
  tags = {
    purpose     = "bastion"
    description = "Serves for SSH access"
    component   = "infra"
  }
}
