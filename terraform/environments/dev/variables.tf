variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block for dev"
  type        = string
  default     = "10.1.0.0/16"
}

variable "azs" {
  description = "Availability zones for dev"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "Public subnets for dev"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnets for dev"
  type        = list(string)
  default     = ["10.1.11.0/24", "10.1.12.0/24"]
}
