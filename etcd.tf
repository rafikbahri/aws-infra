module "etcd-subnet" {
  source              = "github.com/rafikbahri/tf-aws-private-subnet"
  name                = "etcd-subnet"
  vpc_id              = module.main-vpc.vpc_id
  availability_zone   = "eu-west-3a"
  cidr_block          = var.etcd_subnet_cidr
  public_subnet_id    = module.bastions-subnet.subnet_id
  has_internet_access = true
  tags = {
    kind  = "private"
    group = "etcd"
  }
}

module "etcd-cluster" {
  source          = "github.com/rafikbahri/tf-aws-node"
  server_count    = var.etcd_cluster_servers_count
  server_prefix   = "etcd"
  ami_id          = "ami-0546127e0cf2c6498"
  instance_type   = "t2.micro"
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
