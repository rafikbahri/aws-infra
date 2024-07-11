variable "server_count" {
  description = "Number of nodes to be created"
  default     = 1
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
  default     = "ami-0546127e0cf2c6498"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "ec2-default"
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
