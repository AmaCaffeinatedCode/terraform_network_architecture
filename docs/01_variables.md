# Terraform Variables

This document outlines the input variables used across the Terraform configuration, including both the root module and reusable child modules. Shared variables are defined once to reduce duplication and promote consistency.

---

## 📦 Shared Variables

The following variables are used across multiple modules with consistent definitions:

| Name          | Description                                | Type           | Default    | Required |
|---------------|--------------------------------------------|----------------|------------|----------|
| `name`        | Name prefix for all resources              | `string`       | _n/a_      | ✅ Yes   |
| `tags`        | Additional tags to apply to resources      | `map(string)`  | `{}`       | ❌ No    |
| `environment` | Deployment environment                     | `string`       | `"dev"`    | ❌ No    |
| `project_url` | URL to the GitHub repository               | `string`       | `""`       | ❌ No    |

These variables are defined in each module for flexibility but are functionally identical.

---

## 📁 Root Module (`env/main.tf`)

| Name           | Description                                  | Type           | Default                               | Required |
|----------------|----------------------------------------------|----------------|---------------------------------------|----------|
| `name`         | Name prefix for all resources                | `string`       | `"terraform_network_architecture"`    | ❌ No    |
| `vpc_cidr`     | CIDR block for the VPC                       | `string`       | `"10.0.0.0/16"`                        | ❌ No    |
| `az`           | List of availability zones                   | `list(string)` | `["us-east-1a", "us-east-1b", "us-east-1c"]` | ❌ No |
| `access_ip`    | IP address for bastion SSH access            | `string`       | `"192.168.1.5/32"`                    | ❌ No    |
| `bastion_ami`  | AMI ID for the bastion host                  | `string`       | _n/a_                                 | ✅ Yes   |
| `private_ami`  | AMI ID for private EC2 instances             | `string`       | _n/a_                                 | ✅ Yes   |
| `instance_type`| EC2 instance type                            | `string`       | `"t2.micro"`                          | ❌ No    |
| `tags`         | Additional tags                              | `map(string)`  | `{ Owner = "infrastructure-team", Project = "terraform_network_architecture" }` | ❌ No |
| `environment`  | Deployment environment                       | `string`       | `"dev"`                               | ❌ No    |
| `project_url`  | URL to the GitHub repository                 | `string`       | `""`                                  | ❌ No    |

---

## 🔹 Module: `ec2`

Uses shared variables: `name`, `tags`, `environment`, `project_url`

| Name                    | Description                                         | Type            | Default        | Required |
|-------------------------|-----------------------------------------------------|------------------|----------------|----------|
| `bastion_ami`          | AMI ID for the bastion host                          | `string`         | _n/a_          | ✅ Yes   |
| `private_ami`          | AMI ID for private EC2 instances                     | `string`         | _n/a_          | ✅ Yes   |
| `instance_type`        | EC2 instance type                                    | `string`         | `"t2.micro"`   | ❌ No    |
| `key_pair_name`        | Name of the key pair for EC2                         | `string`         | `"bastion_key"`| ❌ No    |
| `subnet_ids`           | Map of subnet IDs (public, private_a, private_b)     | `object`         | _n/a_          | ✅ Yes   |
| `security_group_ids`   | Map of security group IDs                            | `object`         | _n/a_          | ✅ Yes   |
| `iam_instance_profile_ssm` | IAM Instance Profile ARN for SSM access        | `string`         | _n/a_          | ✅ Yes   |

---

## 🔹 Module: `networking`

Uses shared variables: `name`, `tags`, `environment`, `project_url`

| Name        | Description                                | Type         | Default | Required |
|-------------|--------------------------------------------|--------------|---------|----------|
| `vpc_id`    | ID of the VPC                              | `string`     | _n/a_   | ✅ Yes   |
| `access_ip` | IP address for SSH access to bastion       | `string`     | _n/a_   | ✅ Yes   |

---

## 🔹 Module: `security`

Uses shared variables: `name`, `tags`, `environment`, `project_url`

_No additional module-specific variables._

---

## 🔹 Module: `ssh_key`

Uses shared variables: `name`, `tags`, `environment`, `project_url`

_No additional module-specific variables._

---

## 🔹 Module: `vpc`

Uses shared variables: `name`, `tags`, `environment`, `project_url`

| Name                     | Description                             | Type            | Default          | Required |
|--------------------------|-----------------------------------------|------------------|------------------|----------|
| `cidr_block`            | CIDR block for the VPC                   | `string`         | `"10.0.0.0/16"`  | ❌ No    |
| `az`                    | Availability Zones for the subnets       | `list(string)`   | _n/a_            | ✅ Yes   |
| `public_subnet_cidr`    | CIDR block for the public subnet         | `string`         | `"10.0.1.0/24"`  | ❌ No    |
| `private_subnet_cidr_a` | CIDR block for private subnet A          | `string`         | `"10.0.2.0/24"`  | ❌ No    |
| `private_subnet_cidr_b` | CIDR block for private subnet B          | `string`         | `"10.0.3.0/24"`  | ❌ No    |
| `enable_dns_support`    | Enable DNS support in the VPC            | `bool`           | `true`           | ❌ No    |
| `enable_dns_hostnames`  | Enable DNS hostnames in the VPC          | `bool`           | `true`           | ❌ No    |

---

> ✅ **Tip:** Variables without default values must be explicitly set, either in `terraform.tfvars`, via CLI, or by your CI/CD pipeline.
