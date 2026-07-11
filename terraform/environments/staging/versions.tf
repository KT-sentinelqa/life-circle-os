terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "lifecircle-os-terraform-state-staging"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lifecircle-os-terraform-locks-staging"
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
