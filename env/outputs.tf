output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value = module.vpc.public_subnet_id
}

output "private_subnet_a_id" {
  description = "Private subnet A ID"
  value = module.vpc.private_subnet_ids[0]
}

output "private_subnet_b_id" {
  description = "Private subnet B ID"
  value = module.vpc.private_subnet_ids[1]
}

output "bastion_sg_id" {
  description = "Security group ID for bastion host"
  value = module.networking.bastion_sg
}

output "private_a_sg_id" {
  description = "Security group ID for private instance A"
  value = module.networking.private_a_sg
}

output "private_b_sg_id" {
  description = "Security group ID for private instance B"
  value = module.networking.private_b_sg
}

output "ssm_instance_profile_arn" {
  description = "IAM instance profile ARN for SSM access"
  value = module.security.ssm_instance_profile_arn
}

output "bastion_instance_id" {
  description = "EC2 instance ID of the bastion host"
  value = module.ec2.bastion_instance_id
}

output "private_a_instance_id" {
  description = "EC2 instance ID of private instance A"
  value = module.ec2.private_a_instance_id
}

output "private_b_instance_id" {
  description = "EC2 instance ID of private instance B"
  value = module.ec2.private_b_instance_id
}
