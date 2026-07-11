# IAM Module

This module provisions the baseline IAM roles required for the LifeCircle OS infrastructure. 

## Resources Provisioned
- **ECS Task Execution Role:** Allows Fargate tasks to pull container images from ECR and publish logs to CloudWatch.
- **ECS Task Role:** The role the application itself assumes to interact with AWS services (e.g., fetching from Secrets Manager, sending emails via SES).
