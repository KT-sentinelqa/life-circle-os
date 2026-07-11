variable "environment" {
  description = "The environment name (e.g., dev, staging, production)."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
