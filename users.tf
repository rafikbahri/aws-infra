module "github-actions-role" {
  source    = "./modules/aws-role"
  role_name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
}

module "github-actions-user" {
  source = "./modules/aws-user"

  username = "github-actions-user"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
}
