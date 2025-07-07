output "bastion_sg" {
  description = "Security Group ID for bastion host"
  value = aws_security_group.bastion_sg.id
}

output "private_a_sg" {
  description = "Security Group ID for private instance A"
  value = aws_security_group.private_a_sg.id
}

output "private_b_sg" {
  description = "Security Group ID for private instance B (SSM)"
  value = aws_security_group.private_b_sg.id
}
