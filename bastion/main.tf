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
              sudo chmod 777 /home/ec2-user/Palo-Alto-PANOS-modules/Initial-files/configuration.py
              yes | sudo yum install pip
              yes | sudo pip install paramiko
              yes | sudo pip install boto3
              aws configure set aws_access_key_id $(var.access_key_id) && aws configure set aws_secret_access_key $(var.secret_key) && aws configure set region $(var.region) && aws configure set output json
              EOF
  network_interface {
  device_index          = 0
  network_interface_id  = aws_network_interface.bastion_nic.id
  }

  network_interface {
  device_index          = 1
  network_interface_id  = aws_network_interface.bastion_nic_2.id
  }
  tags = {
    Name = "BastionHost"
  }
}

resource "aws_network_interface" "bastion_nic" {
  subnet_id       = var.bastion_mgmt_subnet_id
  security_groups = var.bastion_security_group_ids
  tags = {
    Name = "${var.bastion_instance_name}-mng"
  }
}

resource "aws_network_interface" "bastion_nic_2" {
  subnet_id       = var.bastion_data_subnet_id
  security_groups = var.bastion_security_group_ids
  tags = {
    Name = "${var.bastion_instance_name}-data"
  }
}

resource "aws_eip" "bastion_eip" {
  domain                   = "vpc"
#  network_interface        = aws_network_interface.management_nic.id
}

resource "aws_eip_association" "bastion_eip_association" {
  allocation_id      = aws_eip.bastion_eip.id
  network_interface_id = aws_network_interface.bastion_nic.id
}
