variable "name" {
  description = "Subnet name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "IPv4 CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone (AZ) where the subnet will be created"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
  type        = bool
  default     = false
}

variable "has_internet_access" {
  description = "Whether this networl has internet access"
  type        = bool
  default     = false
}

variable "public_internet_route_table_id" {
  description = "Public internet route table ID"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources in the subnet"
  type        = map(string)
  default     = {}
}