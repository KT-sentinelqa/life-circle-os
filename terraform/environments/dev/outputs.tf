output "vpc_id" {
  description = "The ID of the Dev VPC"
  value       = module.networking.vpc_id
}

output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role for Dev"
  value       = module.iam.ecs_task_execution_role_arn
}
