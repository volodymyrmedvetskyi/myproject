variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "subnet_id" {
  description = "To What Subnet It Will Be Attached"
  type        = string
}

variable "sg_id" {
  description = "Security Group Name"
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