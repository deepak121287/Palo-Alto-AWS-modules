resource "aws_instance" "bastion" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git
              cd /home/ec2-user
              git clone https://github.com/<your-username>/<your-repo>.git
              chmod +x /home/ec2-user/<your-repo>/<your-script>.sh
              /home/ec2-user/<your-repo>/<your-script>.sh
              EOF

  tags = {
    Name = "BastionHost"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}