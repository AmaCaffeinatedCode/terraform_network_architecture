variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "project_url" {
  description = "URL to the GitHub repository for the project"
  type        = string
  default     = ""
}
