variable "sg_name" {
  description = "Security Group Name"
  type        = string
}

variable "vpc_id" {
  description = "To What VPC It Will Be Attached"
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