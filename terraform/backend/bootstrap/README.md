# Terraform Bootstrap Module

This module provisions the remote state backend required for the rest of the LifeCircle OS infrastructure. 

It provisions:
1. An Amazon S3 bucket to store the encrypted Terraform state files (`.tfstate`).
2. An Amazon DynamoDB table for state locking to prevent concurrent apply operations from corrupting the state.

## Usage
Run this module **once** per AWS account using local state, then migrate the state of this module into itself (or keep it local, as it rarely changes).

```hcl
module "bootstrap" {
  source      = "./backend/bootstrap"
  bucket_name = "lifecircle-os-terraform-state-prod"
  table_name  = "lifecircle-os-terraform-locks-prod"
  environment = "production"
}
```
