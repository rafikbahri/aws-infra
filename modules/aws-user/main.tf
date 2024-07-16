resource "aws_iam_user" "user" {
  name          = var.username
  path          = var.path
  force_destroy = var.force_destroy
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy_attachment" "policy_attachment" {
  count      = length(var.policy_arns)
  user       = aws_iam_user.user.name
  policy_arn = var.policy_arns[count.index]
}