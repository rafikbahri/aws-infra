resource "aws_iam_group" "group" {
  name = var.group_name
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the group"
  type        = list(string)
  default     = []
}


resource "aws_iam_group_policy_attachment" "policy_attach" {
  count      = length(var.policy_arns)
  group      = aws_iam_group.group.name
  policy_arn = var.policy_arns[count.index]
}