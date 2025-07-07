resource "aws_iam_role" "ssm_role" {
  name = "${var.name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-ssm-role"
      project_url = var.project_url
    }
  )
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.name}-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name

  tags = merge(
    var.tags,
    {
      Name        = "${var.name}-ssm-instance-profile"
      project_url = var.project_url
    }
  )
}
