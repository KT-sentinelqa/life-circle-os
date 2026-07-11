terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_region" {
  description = "The AWS region to deploy the state backend into"
  type        = string
  default     = "us-east-1"
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = "LifeCircle OS"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
