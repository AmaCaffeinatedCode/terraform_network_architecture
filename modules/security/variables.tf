variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "tags" {
  description = "Tags for IAM resources"
  type        = map(string)
  default     = {}
}

variable "project_url" {
  description = "URL to the GitHub repository for the project"
  type        = string
  default     = ""
}
