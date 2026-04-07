# 🚀 Terraform AWS VPC – Production Level (Cost Optimized)

## 📌 Overview

This project demonstrates a **production-style AWS VPC architecture** built using Terraform.

It follows industry best practices:

* Multi-AZ deployment for high availability
* Public & Private subnet segregation
* Controlled internet access using NAT Gateway
* Cost optimization using a single NAT Gateway

---

## 🏗️ Architecture Summary

* **1 VPC** → CIDR: `10.0.0.0/16`
* **3 Public Subnets** → across 3 Availability Zones
* **3 Private Subnets** → across 3 Availability Zones
* **1 Internet Gateway** → for public access
* **1 NAT Gateway** → for private subnet internet access
* **Route Tables** → separate for public and private traffic
* **DNS enabled** → for internal communication

---

## 🌐 Architecture Diagram

```
                         🌍 Internet
                              │
                              ▼
                     +------------------+
                     | Internet Gateway |
                     +------------------+
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
+---------------+   +---------------+   +---------------+
| Public Subnet |   | Public Subnet |   | Public Subnet |
|   AZ-1        |   |   AZ-2        |   |   AZ-3        |
+---------------+   +---------------+   +---------------+
        │
        ▼
  +---------------------+
  |    NAT Gateway      |
  | (Single - Low Cost) |
  +---------------------+
        │
        ├──────────────┬──────────────┐
        ▼              ▼              ▼
+---------------+ +---------------+ +---------------+
| Private Subnet| | Private Subnet| | Private Subnet|
|   AZ-1        | |   AZ-2        | |   AZ-3        |
+---------------+ +---------------+ +---------------+
```

---

## 🔁 Traffic Flow

### 🌍 Public Subnets

* Route: `0.0.0.0/0 → Internet Gateway`
* Used for:

  * Load Balancer
  * Bastion Host
  * NAT Gateway

---

### 🔒 Private Subnets

* Route: `0.0.0.0/0 → NAT Gateway`
* Used for:

  * Application Servers
  * Backend Services
* No direct internet access (secure)

---

## ⚙️ Terraform Configuration

### Provider

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

---

### VPC Module

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "prod-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "production"
    Project     = "terraform-vpc"
  }
}
```

---

## ▶️ How to Run

```bash
terraform init
terraform plan
terraform apply
```

---

## ❌ Destroy Infrastructure

```bash
terraform destroy
```

---

## 💡 Design Decisions

### ✅ Multi-AZ Deployment

* Improves availability
* Handles AZ-level failures

### ✅ Subnet Segregation

* Public → Internet-facing resources
* Private → Secure backend

### ✅ Single NAT Gateway

* Reduces cost 💸
* Trade-off: lower availability if AZ fails

---

## 🔐 Security Best Practices

* No direct internet access to private subnets
* NAT Gateway only allows outbound traffic
* Public exposure limited to required components

---

## 📁 Project Structure

```
terraform-vpc/
│── main.tf
│── provider.tf
│── variables.tf
│── README.md
│── .gitignore
```

---

## 🚀 Future Enhancements

* Add Bastion Host (SSH access)
* Add Application Load Balancer (ALB)
* Deploy EC2 in private subnet
* Add Auto Scaling Group
* Add RDS in private subnet
* Implement CI/CD pipeline

---

## 🧠 Interview Explanation

> I designed a production-ready VPC using Terraform with multi-AZ public and private subnets. Public subnets are connected to an Internet Gateway, while private subnets use a NAT Gateway for outbound internet access. The architecture ensures high availability, security, and cost optimization by using a single NAT Gateway.

---

## 👨‍💻 Author

**Rahul Shambharkar**
AWS | DevOps Engineer
