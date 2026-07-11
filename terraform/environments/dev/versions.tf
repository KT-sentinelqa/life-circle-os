terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    # These values must match the resources created in backend/bootstrap
    bucket         = "lifecircle-os-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lifecircle-os-terraform-locks-dev"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
