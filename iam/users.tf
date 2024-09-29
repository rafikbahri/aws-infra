# Mandatory for GH Actions terraform plan
resource "aws_iam_policy" "describe_az_policy" {
  name        = "EC2DescribeAvailabilityZonesPolicy"
  path        = "/"
  description = "IAM policy for describing EC2 Availability Zones"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ec2:DescribeAvailabilityZones"
        Resource = "*"
      },
    ]
  })
}

module "github-actions-user" {
  source   = "./modules/aws-user"
  username = "github-actions"
  path     = "/system/"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    aws_iam_policy.describe_az_policy.arn
  ]
  tags = {
    type    = "service"
    context = "ci"
    tool    = "github-actions"
  }
}

resource "local_sensitive_file" "github-actions-credentials" {
  filename        = pathexpand("~/.config/aws-github-actions")
  content         = <<-EOT
          export GH_AWS_ACCESS_KEY_ID=${module.github-actions-user.access_key_id}
          export GH_AWS_SECRET_ACCESS_KEY=${module.github-actions-user.secret_access_key}
          EOT
  file_permission = "0600"
}