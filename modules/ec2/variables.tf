variable "name" {
  description = "Name prefix for all resources"
  type = string
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
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

variable "key_pair_name" {
  description = "Name of the key pair to associate with EC2 instances"
  type = string
  default = "bastion_key"
}

variable "subnet_ids" {
  description = "Map of subnet IDs: public, private_a, private_b"
  type = object({
    public = string
    private_a = string
    private_b = string
  })
}

variable "security_group_ids" {
  description = "Map of security groups: bastion_sg, private_a_sg, private_b_sg"
  type = object({
    bastion_sg = string
    private_a_sg = string
    private_b_sg = string
  })
}

variable "iam_instance_profile_ssm" {
  description = "IAM Instance Profile ARN for the EC2 instance with SSM access"
  type = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type = map(string)
  default = {}
}

variable "project_url" {
  description = "URL to the GitHub repository for the project"
  type = string
  default = ""
}
