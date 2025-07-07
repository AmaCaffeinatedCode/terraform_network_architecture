output "bastion_instance_id" {
  description = "ID of the bastion host instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "private_a_instance_id" {
  description = "ID of the private instance A (accessed via bastion)"
  value       = aws_instance.private_a.id
}

output "private_b_instance_id" {
  description = "ID of the private instance B (accessed via SSM)"
  value       = aws_instance.private_b.id
}
