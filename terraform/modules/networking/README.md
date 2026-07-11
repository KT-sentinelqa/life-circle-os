# Networking Module

This module provisions the core network infrastructure for LifeCircle OS. It is designed around AWS VPC best practices.

## Resources Provisioned
- 1 VPC
- Public Subnets (for ALBs/NAT Gateways)
- Private Subnets (for ECS, RDS, ElastiCache)
- Internet Gateway (IGW)
- NAT Gateways (1 per AZ for high availability in Production, 1 total for Dev)
- Route Tables and associations
