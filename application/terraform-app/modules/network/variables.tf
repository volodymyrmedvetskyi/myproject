variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "List of Public Subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidr" {
  description = "List of Private Subnet CIDRs"
  type        = list(string)
}

variable "a_z" {
  description = "List of Availability Zones"
  type        = list(string)
}