# Core Networking
module "networking" {
  source = "../../modules/networking"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  
  # For Production, we use Multi-AZ NAT Gateways for High Availability
  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    ManagedBy = "Terraform"
    Project   = "LifeCircleOS"
  }
}

# IAM Baseline
module "iam" {
  source = "../../modules/iam"

  environment = var.environment

  tags = {
    ManagedBy = "Terraform"
    Project   = "LifeCircleOS"
  }
}
