output "ssm_role_name" {
  description = "IAM Role name for SSM"
  value       = aws_iam_role.ssm_role.name
}

output "ssm_instance_profile_arn" {
  description = "IAM Instance Profile ARN for SSM"
  value       = aws_iam_instance_profile.ssm_instance_profile.arn
}
