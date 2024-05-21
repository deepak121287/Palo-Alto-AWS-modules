output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_nic_private_ip" {
  value = aws_network_interface.bastion_nic.private_ip
}

output "bastion_eip" {
  value = aws_eip.bastion_eip.public_ip
}