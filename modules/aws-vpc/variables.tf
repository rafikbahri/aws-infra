variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "Tenancy for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "name" {
  description = "VPC name"
  type        = string
}

variable "tags" {
  description = "VPC tags"
  type        = map(string)
  default     = {}
}

variable "create_igw" {
  description = "Create an Internet Gateway for public subnets"
  type        = bool
  default     = true
}