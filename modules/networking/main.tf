resource "aws_security_group" "bastion_sg" {
  name        = "${var.name}-bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from access IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.access_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-bastion-sg",
      Environment = var.environment,
      project_url = var.project_url
    }
  )
}

resource "aws_security_group" "private_a_sg" {
  name        = "${var.name}-private-a-sg"
  description = "SG for EC2 in private subnet A"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-private-a-sg",
      Environment = var.environment,
      project_url = var.project_url
    }
  )
}

resource "aws_security_group" "private_b_sg" {
  name        = "${var.name}-private-b-sg"
  description = "SG for EC2 with SSM access (no ingress needed)"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-private-b-sg",
      Environment = var.environment,
      project_url = var.project_url
    }
  )
}
