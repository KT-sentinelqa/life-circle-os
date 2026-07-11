variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "vpc_cidr" {
  description = "VPC CIDR block for staging"
  type        = string
  default     = "10.2.0.0/16"
}

variable "azs" {
  description = "Availability zones for staging"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "Public subnets for staging"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnets for staging"
  type        = list(string)
  default     = ["10.2.11.0/24", "10.2.12.0/24"]
}
