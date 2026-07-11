output "s3_bucket_name" {
  description = "The name of the S3 bucket storing the state."
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table handling state locking."
  value       = aws_dynamodb_table.terraform_locks.name
}
