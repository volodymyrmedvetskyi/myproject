variable "sg_name" {
  description = "Security Group Name"
  type        = string
}

variable "vpc_id" {
  description = "To What VPC It Will Be Attached"
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