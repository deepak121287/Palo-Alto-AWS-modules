variable "palo_alto_ami" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "management_subnet_id" {
  type        = string
}

variable "data_subnet_id" {
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "security_group_ids" {
  type        = list(string)
}

variable "instance_name" {
  type        = string
}

# variable "admin_password" {
#   type        = string
# }