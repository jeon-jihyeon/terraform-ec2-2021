variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "aws_region" {
  type        = string
  description = "the AWS region in which resources are created"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "dev"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC"
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC"
}

variable "office_cidr" {
  description = "Bastion host SG ingress cidr"
}

variable "amazon_linux_ami" {
  description = "amazon linux ami"
}

variable "domain_name" {
  description = "domain name"
}

variable "tsl_certificate_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}

variable "health_check_path" {
  description = "Http path for task health check"
}

variable "alb_account_id" {
  description = "AWS ALB Account ID"
}

variable "listener_rule_key" {
  description = "listener rule key"
}

variable "rds_pg_family" {
  description = "Family of RDS Parameter Group"
}

variable "rds_allocated_storage" {
  description = "Size of RDS Storage"
}

variable "rds_max_storage" {
  description = "Size of RDS Storage"
}

variable "rds_engine" {
  description = "DBMS Engine"
}

variable "rds_engine_version" {
  description = "DBMS Engine Version"
}

variable "rds_instance_class" {
  description = "RDS Intance Class"
}

variable "rds_storage_type" {
  description = "RDS Storage Type"
}

variable "database_name" {
  description = "The RDS database name"
}

variable "database_user" {
  description = "The RDS database admin user"
}

variable "database_password" {
  description = "The RDS database admin password"
}

variable "database_port" {
  description = "The port where the RDS is exposed"
}

variable "ec2_t3_nano_type" {
  description = "EC2 instance type"
}

variable "ec2_t2_micro_type" {
  description = "EC2 instance type"
}

variable "bastion_key_path" {
  description = "Path to ssh key"
}

variable "backend_key_path" {
  description = "Path to ssh key"
}

variable "recent_rds_name" {
  description = "RDS name of recent version"
}