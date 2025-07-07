variable "name" {
  description = "Name prefix for all resources"
  type = string
  default = "terraform_network_architecture"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "az" {
  description = "List of availability zones"
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "access_ip" {
  description = "Your IP for bastion SSH access"
  type = string
  default = "0.0.0.0/0" # Replace with the actual IP for better security
}

variable "bastion_ami" {
  description = "AMI ID for bastion host"
  type = string
}

variable "private_ami" {
  description = "AMI ID for private EC2 instances"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for bastion SSH"
  type = string
  default = null
}

variable "tags" {
  description = "Common tags for all resources"
  type = map(string)
  default = {
    Owner = "infrastructure-team"
    Environment = "production"
    Project = "terraform_network_architecture"
  }
}

variable "project_url" {
  description = "URL to the GitHub repository for the project"
  type = string
  default = ""
}
