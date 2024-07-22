variable "username" {
  description = "IAM user name"
  type        = string
}

variable "path" {
  description = "Path in which to create the user"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  type        = bool
  default     = false
}

variable "policy_arns" {
  description = "List of policy ARNs to attach to the user"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to this user"
  type        = map(string)
  default     = {}
}
