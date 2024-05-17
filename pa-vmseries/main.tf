resource "aws_instance" "palo_alto" {
  ami                        = var.palo_alto_ami
  instance_type              = var.instance_type
  key_name                   = var.key_name

  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.data_nic.id
  }
  network_interface {
    device_index          = 1
    network_interface_id  = aws_network_interface.management_nic.id
  }
  tags = {
    Name = var.instance_name
  }
}

resource "aws_network_interface" "data_nic" {
  subnet_id       = var.data_subnet_id
  security_groups = var.security_group_ids
  tags = {
    Name = "${var.instance_name}-data"
  }
}
resource "aws_network_interface" "management_nic" {
  subnet_id       = var.management_subnet_id
  security_groups = var.security_group_ids
  tags = {
    Name = "${var.instance_name}-management"
  }
}

resource "aws_eip" "management_eip" {
  instance                 = aws_instance.palo_alto.id
  domain                   = "vpc"
  network_interface        = aws_network_interface.management_nic.id
}


