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

### Prerequisites

- A remote backend and state lock table must be provisioned and accessible (S3 bucket and DynamoDB table) before running the pipeline.
- An existing secure S3 bucket for SSH private key storage. The bucket name should be set as a secret (`SECURE_ARTIFACTS_BUCKET`) in your CI/CD environment.


### 1. Environment variables

The GitHub Actions CI/CD pipeline uses the following secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `ACCESS_IP` – restricts SSH ingress from your IP
- `SECURE_ARTIFACTS_BUCKET` – name of an existing S3 bucket where the SSH private key will be securely uploaded by the pipeline.

### 2. Deployment

Clone the repository and push changes to trigger the CI/CD workflow.

---

## CI/CD Pipeline

A GitHub Actions workflow (`.github/workflows/deploy.yml`) is included to automate Terraform validation and deployment.

The pipeline:
- Initializes Terraform  
- Formats and validates Terraform code  
- Generates and applies a Terraform plan  
- Uploads the SSH private key to an S3 bucket

It uses GitHub Actions environment secrets for secure authentication.  
The `PROJECT_URL` variable is injected automatically by the pipeline and passed to Terraform for tagging purposes.

---

## Variables

Refer to the [docs/variables.md](docs/variables.md) file for full variable details.

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

Refer to the [docs/outputs.md](docs/outputs.md) file for full outputs details.
