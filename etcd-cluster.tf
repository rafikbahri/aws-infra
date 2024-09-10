module "etcd-subnet" {
  source              = "./modules/aws-private-subnet"
  name                = "etcd-subnet"
  vpc_id              = module.main-vpc.vpc_id
  availability_zone   = "eu-west-3a"
  cidr_block          = var.etcd_subnet_cidr
  public_subnet_id    = module.bastions-subnet.subnet_id
  has_internet_access = true
  tags = {
    kind  = "public"
    group = "etcd"
  }
}

module "etcd-cluster" {
  source          = "./modules/aws-node"
  server_count    = var.etcd_cluster_servers_count
  server_prefix   = "etcd"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  vpc_id          = module.main-vpc.vpc_id
  subnet_id       = module.etcd-subnet.subnet_id
  private_ips     = [["192.168.16.11"], ["192.168.16.12"], ["192.168.16.13"]]
  create_key      = false
  security_groups = [module.sg-admin.sg_id]
  user_data_file  = ".config/cloudinit_user_data.yaml"
  tags = {
    component = "etcd"
    tier      = "infra"
  }
}
