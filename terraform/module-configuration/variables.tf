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

variable "from_port_in" {
  description = "Start Port For Inbound Traffic"
  type        = number
}

variable "to_port_in" {
  description = "End Port For Inbound Traffic"
  type        = number
}

variable "cidr_block_in" {
  description = "List of CIDR Blocks For Inbound Traffic"
  type        = list(string)
}

variable "vm_count" {
  description = "How Many Instances Do We Need"
  type = number
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "vm_name" {
  description = "List Of Tag Names For Name Key"
  type        = list(string)
}

variable "vm_environment" {
  description = "Tag Name For environment Key"
  type        = string
}

variable "vm_role" {
  description = "List Of Tag Names For role Key"
  type        = list(string)
}

variable "monitoring_vm_name" {
  description = "Tag Name For Name Key of Monitoring Server"
  type        = string
}

variable "monitoring_vm_role" {
  description = "Tag Name For role Key of Monitoring Server"
  type        = string
}