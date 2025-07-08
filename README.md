# Terraform AWS Network Architecture

A modular Terraform setup that builds a secure and production-like AWS network infrastructure, featuring EC2 access via a bastion host and SSM, following best practices for scalability, automation, and maintainability.

---

## Project Overview

This project provisions a foundational AWS network architecture with the following:

- Custom VPC with:
  - 1 public subnet  
  - 2 private subnets  
  - Spread across multiple availability zones  
- Internet Gateway and NAT Gateway for internet access  
- Route tables for both public and private subnet traffic management  
- 3 EC2 instances:
  - Bastion host in the public subnet for SSH access  
  - Private EC2 instance accessed via the bastion host  
  - Private EC2 instance accessed via AWS Systems Manager (SSM)  
- SSH key pair created and configured for the bastion and SSH-access EC2 instance  
- Security groups for:
  - Bastion host  
  - Private instance accessed via SSH  
  - Private instance accessed via SSM  
- IAM role and instance profile configured to enable SSM connectivity  

**Prerequisite:** A remote backend configured separately to manage Terraform state, consisting of:
- An S3 bucket for centralized state storage  
- A DynamoDB table for state locking  

---


## CI/CD Pipeline

A GitHub Actions workflow (`.github/workflows/deploy.yml`) is included to automate Terraform validation on every push. The pipeline:

- Initializes Terraform  
- Formats and validates Terraform code 
- Generates a Terraform plan for review

It uses GitHub Actions environment secrets for secure authentication.

---

## Usage

### 1. Environment variables

The GitHub Actions CI/CD pipeline uses the following secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `ACCESS_IP` – used to restrict SSH ingress from your IP
- `PROJECT_URL` – injected automatically by the pipeline.

### 2. Deployment

Clone the repository and push changes to trigger the CI/CD workflow.

> _Note: This project is intended for demonstration and validation purposes. CI/CD is configured for planning only, but can be extended to support automated deployment._

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
