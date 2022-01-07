# Terraform-EC2
Terraform을 사용하여 AWS EC2 Resource 프로비저닝
- Terraform v0.12.23
    + provider registry.terraform.io/providers/hashicorp/aws v3.66.0

## Prerequsite
- aws cli v2
- s3 bucket for terraform state backend 
- iam user
- ssl certification
- domain

## Resource
- VPC 
- AZ subnets
- Routing tables
- Internet Gateway
- NAT instance
- EC2 instance
- Security groups
- ALB
- RDS
- S3
- CodeDeploy
- .yml files for gitaction
- scripts files for codedeploy

![aws-architecture-v100](https://user-images.githubusercontent.com/63345897/147190524-0bb95fad-852f-4e4f-8542-7427b8515a68.jpg)

## Source Structure
- [Standard Module Structure](https://www.terraform.io/language/modules/develop/structure)
    + separated by environment