module "github-actions-user" {
  source = "./modules/aws-user"

  username = "github-actions-user"
  path     = "/system/"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
  tags = {
    type    = "service"
    context = "ci"
    tool    = "github-actions"
  }
}