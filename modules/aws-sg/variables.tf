variable "vpc_id" {
  description = "Associated VPC ID"
  type        = string
  default     = ""
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = list(any)
  default     = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type        = list(any)
  default     = []
}

variable "name" {
  description = "Name of the security group"
  type        = string
  default     = "security_group"
}

variable "description" {
  description = "Security group description"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Security group tags"
  type        = map(string)
  default     = {}
}
