module "github-actions-user" {
  source = "./modules/aws-user"

  username = "github-actions"
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

resource "local_sensitive_file" "github-actions-credentials" {
  filename = pathexpand("~/.config/aws-github-actions")

  content         = <<-EOT
          export GH_AWS_ACCESS_KEY_ID=${module.github-actions-user.access_key_id}
          export GH_AWS_SECRET_ACCESS_KEY=${module.github-actions-user.secret_access_key}
          EOT
  file_permission = "0600"
}