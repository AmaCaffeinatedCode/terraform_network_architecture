resource "aws_instance" "bastion" {
  ami = var.bastion_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_ids.public
  vpc_security_group_ids = [var.security_group_ids.bastion_sg]
  key_name = var.key_pair_name
  associate_public_ip_address = true
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-bastion-host",
      project_url = var.project_url
    }
  )
}

resource "aws_instance" "private_a" {
  ami = var.private_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_ids.private_a
  vpc_security_group_ids = [var.security_group_ids.private_a_sg]
  key_name = var.key_pair_name
  associate_public_ip_address = false
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-instance-a",
      project_url = var.project_url
    }
  )
}

resource "aws_instance" "private_b" {
  ami = var.private_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_ids.private_b
  vpc_security_group_ids = [var.security_group_ids.private_b_sg]
  associate_public_ip_address = false
  iam_instance_profile = var.iam_instance_profile_ssm
  # No key_name because accessed only via SSM
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-instance-b",
      project_url = var.project_url
    }
  )
}
