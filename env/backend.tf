terraform {
  backend "s3" {
    bucket = "terraform-remote-state-central-bucket"
    key = "terraform_network_architecture/production/terraform.tfstate"  # adjust for env
    region = "us-east-1"
    dynamodb_table = "terraform-remote-state-lock-table"
    encrypt = true
  }
}
