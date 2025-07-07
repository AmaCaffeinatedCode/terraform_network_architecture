name = "terraform_network_architecture"

vpc_cidr = "10.0.0.0/16"
az = ["us-east-1a", "us-east-1b", "us-east-1c"]

# "access_ip" variable will be set dinamically in the CI/CD pipeline

bastion_ami = "ami-0123456789abcdef0"
private_ami = "ami-0fedcba9876543210"

instance_type = "t2.micro"

tags = {
  Environment = "production"
  Owner = "infrastructure-team"
  Project = "terraform_network_architecture"
}

# "project_url" will be set dinamically in the CI/CD pipeline