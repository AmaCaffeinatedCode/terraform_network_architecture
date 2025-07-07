variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az" {
  description = "Availability Zone for the subnets"
  type        = list(string)
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_a" {
  description = "CIDR block for private subnet A"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_b" {
  description = "CIDR block for private subnet B"
  type        = string
  default     = "10.0.3.0/24"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "project_url" {
  description = "URL to the GitHub repository for this project"
  type        = string
  default     = ""
}
