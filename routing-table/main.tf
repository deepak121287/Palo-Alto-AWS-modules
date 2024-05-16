resource "aws_route_table" "rtb" {
  vpc_id = var.vpc_id
  
  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
    }
  }

  tags = var.tags
}