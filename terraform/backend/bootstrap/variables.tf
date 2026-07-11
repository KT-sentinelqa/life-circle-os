variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform state storage. Must be globally unique."
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table for Terraform state locking."
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, production) for tagging."
  type        = string
}

variable "tags" {
  description = "Additional tags for the resources."
  type        = map(string)
  default     = {}
}
