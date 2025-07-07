output "key_pair_name" {
  description = "The name of the generated AWS key pair"
  value = aws_key_pair.bastion.key_name
}
