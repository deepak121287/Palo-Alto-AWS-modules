variable "vpc_id" {}
variable "routes" {
  description = "multiple list of routes to add to the routing table"
  type        = list(object({
    cidr_block = string
    gateway_id = string
  }))
}

variable "tags" {}

