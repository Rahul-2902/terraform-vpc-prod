module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "prod-vpc"
  cidr = var.vpc_cidr

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

  # Public subnets (3 AZ)
  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  # Private subnets (3 AZ)
  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]


  # NAT Gateway (ONLY ONE → cost saving)
  enable_nat_gateway  = true
  single_nat_gateway  = true

  # DNS (important)
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "production"
    Project     = "vpc-demo"
  }
}
