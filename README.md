# Terraform AWS Multi-Environment Infrastructure

This project provisions a modular, scalable AWS infrastructure using Terraform, designed with environment isolation and production-inspired architecture patterns.

It demonstrates how to manage infrastructure across multiple environments (**dev, staging, prod**) while maintaining reusable and maintainable modules.

---

## Architecture Overview

```
Internet → Application Load Balancer → Auto Scaling EC2 → RDS (Private Subnets)
                                          ↘ S3 Object Storage
```

---

## Key Highlights

* Multi-environment architecture (**dev, staging, prod**)
* Modular Terraform design (reusable components)
* Environment-isolated configurations and state
* Highly available multi-tier AWS architecture (Multi-AZ)
* Scalable compute using Auto Scaling Groups
* CI/CD workflow using GitHub Actions

---

## Project Structure

```
multi-env-infra/
│
├── dev/        # Development environment (lightweight, cost-efficient)
├── staging/    # Pre-production environment (production-like testing)
├── prod/       # Production environment (high availability, scalable)
│
└── modules/
    ├── vpc/
    ├── sg/
    ├── ec2/
    ├── alb/
    ├── rds/
    ├── s3/
    └── iam/
```

* `modules/` → reusable infrastructure components
* `dev/`, `staging/`, `prod/` → environment-specific configurations

---

## Environment Strategy

| Environment | Purpose                   | Characteristics             |
| ----------- | ------------------------- | --------------------------- |
| dev         | Development & testing     | Minimal resources, low cost |
| staging     | Pre-production validation | Mirrors production behavior |
| prod        | Production                | High availability & scaling |

Each environment has its own:

* Configuration (`terraform.tfvars`)
* State file (isolated backend)
* Resource naming (e.g., `dev-alb`, `staging-alb`, `prod-alb`)

---

## Infrastructure Components

### Networking (VPC)

* Custom VPC with public and private subnets
* Multi-AZ deployment for high availability
* Internet Gateway and route tables configured

---

### Compute (EC2 + Auto Scaling)

* Launch Templates for consistent instance configuration
* Auto Scaling Groups for dynamic scaling
* Integrated with ALB target groups

---

### Load Balancing (ALB)

* Distributes traffic across EC2 instances
* Health checks for resilience

---

### Data Layer

* RDS deployed in private subnets (not publicly accessible)
* S3 bucket for object storage

---

### Security

* Security groups for traffic control
* IAM roles and instance profiles
* Principle of least privilege

---

## CI/CD Workflow

Implemented using GitHub Actions:

### On Pull Request

* terraform fmt -check
* terraform validate
* terraform plan

### On Push to `main`

* terraform apply

This ensures infrastructure changes are validated before deployment.

---

## Deployment

Deploy a specific environment:

### Development

```bash
cd dev
terraform init
terraform plan
terraform apply
```

### Staging

```bash
cd staging
terraform init
terraform plan
terraform apply
```

### Production

```bash
cd prod
terraform init
terraform plan
terraform apply
```

---

## Configuration

Each environment uses its own:

```
terraform.tfvars
```

This allows:

* Different instance sizes
* Different scaling configurations
* Environment-specific tuning

---

## Technologies Used

* Terraform
* AWS (VPC, EC2, ALB, RDS, S3, IAM)
* GitHub Actions

---

