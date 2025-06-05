data "aws_ami" "marketplace_ami" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["TheHive*"]
  }
}

module "thehive-subnet" {
  source              = "github.com/rafikbahri/tf-aws-private-subnet"
  name                = "thehive-subnet"
  vpc_id              = module.main-vpc.vpc_id
  availability_zone   = "eu-west-3a"
  cidr_block          = var.thehive_subnet_cidr
  public_subnet_id    = module.bastions-subnet.subnet_id
  has_internet_access = true
  tags = {
    kind  = "private"
    group = "thehive"
  }
}

module "thehive-cluster" {
  source          = "github.com/rafikbahri/tf-aws-node"
  server_count    = var.thehive_cluster_servers_count
  server_prefix   = "thehive"
  ami_id          = data.aws_ami.marketplace_ami.id
  instance_type   = "m6i.xlarge"
  vpc_id          = module.main-vpc.vpc_id
  subnet_id       = module.thehive-subnet.subnet_id
  private_ips     = [["192.168.17.11"]]
  create_key      = false
  security_groups = [module.sg-admin.sg_id]
  user_data_file  = ".config/cloudinit_user_data.yaml"
  tags = {
    component = "thehive"
    tier      = "infra"
  }
}

