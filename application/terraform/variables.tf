variable "region" {
  description = "AWS Region"
  type        = string
}

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

variable "sg_name" {
  description = "Security Group Name"
  type        = string
}

variable "ports_in" {
  description = "Ports For Inbound Traffic"
  type        = list(number)
}

variable "cidr_block_in" {
  description = "List of CIDR Blocks For Inbound Traffic"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "vm_name" {
  description = "Tag Name For Name Key"
  type        = string
}

variable "vm_environment" {
  description = "Tag Name For environment Key"
  type        = string
}

variable "vm_role" {
  description = "Tag Name For role Key"
  type        = string
}