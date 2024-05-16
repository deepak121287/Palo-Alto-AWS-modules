resource "aws_subnet" "subnets" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.subnet_name}-subnet"
  }
}
