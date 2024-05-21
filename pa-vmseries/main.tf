resource "aws_instance" "palo_alto" {
  ami                        = var.palo_alto_ami
  instance_type              = var.instance_type
  key_name                   = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    echo "mgmt-interface-swap=enable" >> /opt/pancfg/mgmt_cfg.xml
    echo "admin_password=${var.admin_password}" >> /opt/pancfg/mgmt_cfg.xml
    /opt/pancfg/wrapper pan_cfg_sync
  EOF
  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.management_nic.id
  }
  network_interface {
    device_index          = 1
    network_interface_id  = aws_network_interface.data_nic.id
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
  domain                   = "vpc"
#  network_interface        = aws_network_interface.management_nic.id
}

resource "aws_eip_association" "management_eip_association" {
  allocation_id      = aws_eip.management_eip.id
  network_interface_id = aws_network_interface.management_nic.id
}

