module "eks-cluster" {
  source                = "github.com/rafikbahri/tf-aws-eks"
  cluster_name          = "eks-cluster"
  vpc_id                = module.main-vpc.vpc_id
  vpc_cidr              = var.vpc_cidr
  public_route_table_id = module.main-vpc.public_internet_route_table_id

  tags = {
    kind = "public"
  }
}
