module "eks-cluster" {
  source                = "github.com/rafikbahri/tf-aws-eks"
  create_cluster        = var.eks_create_cluster
  cluster_name          = "eks-cluster"
  vpc_id                = module.main-vpc.vpc_id
  vpc_cidr              = module.main-vpc.vpc_cidr_block
  public_route_table_id = module.main-vpc.public_internet_route_table_id
  tags = {
    kind = "private"
  }
}
