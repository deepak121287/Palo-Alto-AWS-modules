output "management_nic_private_ip" {
  value = aws_network_interface.management_nic.private_ip
}
output "data_nic_private_ip" {
  value = aws_network_interface.data_nic.private_ip
}
output "palo_alto_instance_id" {
  value = aws_instance.palo_alto.id
}