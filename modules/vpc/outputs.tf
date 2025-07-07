output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value = aws_subnet.public.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
  ]
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value = aws_nat_gateway.nat.id
}
