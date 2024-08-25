module "sg-ssm" {
  source      = "./modules/aws-sg"
  name        = "sg_ssm"
  description = "Allow SSM traffic"
  vpc_id      = module.main-vpc.vpc_id
  egress_rules = [
    {
      description = "Allow SSM traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      # Required attribues: https://stackoverflow.com/a/69080432/5684155
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "Allow SSM"
  }
}
