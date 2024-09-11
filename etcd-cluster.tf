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

module "sg-etcd" {
  source      = "./modules/aws-sg"
  name        = "sg_etcd"
  description = "Etcd member security group"
  vpc_id      = module.main-vpc.vpc_id
  ingress_rules = [
    {
      description = "Etcd listen to clients port."
      from_port   = 2379
      to_port     = 2379
      protocol    = "tcp"
      cidr_blocks = []
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description = "Etcd listen to peers port."
      from_port   = 2380
      to_port     = 2380
      protocol    = "tcp"
      cidr_blocks = []
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]
  egress_rules = [
    {
      description      = "Allow all outbound traffic."
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]
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
  security_groups = [module.sg-admin.sg_id, module.sg-etcd.sg_id]
  user_data_file  = ".config/cloudinit_user_data.yaml"
  tags = {
    component = "etcd"
    tier      = "infra"
  }
}
