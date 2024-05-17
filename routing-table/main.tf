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

resource "aws_route_table_association" "subnet_association" {
  for_each = toset(var.subnet_ids)
  subnet_id = each.value
  route_table_id = aws_route_table.rtb.id
}