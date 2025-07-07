resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "bastion" {
  key_name = "${var.name}-key-pair"
  public_key = tls_private_key.bastion.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-key-pair"
      project_url = var.project_url
    }
  )
}

resource "local_file" "private_key" {
  content = tls_private_key.bastion.private_key_pem
  filename = "${path.module}/${var.name}-key-pair.pem"
  file_permission = "0400"
  directory_permission = "0700"
}
