module "github-actions-user" {
  source = "./modules/aws-user"

  username = "github-actions-user"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
}
