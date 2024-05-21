resource "aws_instance" "bastion" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git
              cd /home/ec2-user
              git clone https://github.com/deepak121287/Palo-Alto-PANOS-modules.git
              chmod +x /home/ec2-user/Palo-Alto-PANOS-modules/configuration.py
              chmod +x /home/ec2-user/Palo-Alto-PANOS-modules/PA-keypair.pem
              EOF
  network_interface {
  device_index          = 0
  network_interface_id  = aws_network_interface.bastion_nic.id
  }
  tags = {
    Name = "BastionHost"
  }
}

resource "aws_network_interface" "bastion_nic" {
  subnet_id       = var.data_subnet_id
  security_groups = var.security_group_ids
  tags = {
    Name = "${var.instance_name}-data"
  }
}
