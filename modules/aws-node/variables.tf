variable "server_count" {
  description = "Number of nodes to be created"
  default     = 0
}

variable "server_prefix" {
  description = "Instance name prefix"
  default     = "ec2"
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Instance tags"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Associated VPC ID"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Associated subnet ID"
  type        = string
  default     = ""
}

variable "private_ips" {
  description = "List of private IPs for this instance"
  type        = list(any)
  default     = []
}


variable "security_groups" {
  description = "List of security groups"
  type        = list(any)
  default     = []
}


variable "has_public_ip" {
  description = "Whether the instance has a public IP address"
  type        = string
  default     = false
}

variable "create_key" {
  description = "Whether to create a key pair or not"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Key pair name"
  type        = string
  default     = "key-pair"
}

variable "ssh_enabled" {
  description = "Whether SSH access to the instance is enabled or not"
  type        = bool
  default     = true
}
