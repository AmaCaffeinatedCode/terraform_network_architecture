# Terraform AWS Network Architecture

---

## Project Overview

This project provisions a secure, modular AWS network architecture using Terraform. It creates a custom VPC with public and private subnets, route configurations, internet/NAT gateways, EC2 instances, IAM roles, and security groups — providing a production-ready networking baseline with both SSH and SSM access.

---

## Resources Created
- VPC with 1 public subnet and 2 private subnets  
- Internet Gateway and NAT Gateway  
- Public and private route tables  
- Bastion EC2 instance (SSH access)  
- Private EC2 instance (SSH via bastion)  
- Private EC2 instance (SSM access)  
- IAM role and instance profile for SSM access  
- Security groups for each instance type  
- Key pair for SSH  

---

## Usage

### 1. Environment variables

The GitHub Actions CI/CD pipeline uses the following secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `ACCESS_IP` – restricts SSH ingress from your IP

### 2. Deployment

Clone the repository and push changes to trigger the CI/CD workflow.

---

## CI/CD Pipeline

A GitHub Actions workflow (`.github/workflows/deploy.yml`) is included to automate Terraform validation and deployment.

The pipeline:
- Initializes Terraform  
- Formats and validates Terraform code  
- Generates and applies a Terraform plan  

It uses GitHub Actions environment secrets for secure authentication.  
The `PROJECT_URL` variable is injected automatically by the pipeline and passed to Terraform for tagging purposes.

---

## Variables

| Variable      | Description                                | Required |
|---------------|--------------------------------------------|----------|
| access_ip     | IP address allowed SSH access to bastion   | Yes      |
| name          | Resources name prefix                      | Yes      |
| tags          | Custom tags to apply to all resources      | Yes      |
| project_url   | Project repository URL                     | Yes      |

---

## Tags

All AWS resources are consistently tagged for clarity, traceability, and ownership. Tags include:

| Key           | Value                                                                                 |
|---------------|---------------------------------------------------------------------------------------|
| `Environment` | `<environment>` (e.g., `production`, `dev`, `staging`)                                |
| `Owner`       | `<team-name>` (e.g., `devops-team`, `backend-team`)                                   |
| `Project`     | `<project-name>`                                                                      |
| `Name`        | `<prefix-name> + <resource-type>` (e.g., `terraform_network_architecture-bastion-sg`) |
| `project_url` | `<project-repo-url>`                                                                  |

---

## Outputs

| Name              | Description                    |
|-------------------|--------------------------------|
| vpc_id            | ID of the created VPC          |
| public_subnet_id  | Public subnet ID               |
| private_subnet_ids| List of private subnet IDs     |
| bastion_ip        | Public IP of the bastion host  |

---

## Additional Notes

- This project uses a remote backend for Terraform state management. Ensure the backend (S3 bucket and DynamoDB table) is provisioned and accessible before running the pipeline.
