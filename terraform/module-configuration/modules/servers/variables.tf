variable "vm_count" {
  description = "How Many Instances Do We Need"
  type = number
}

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