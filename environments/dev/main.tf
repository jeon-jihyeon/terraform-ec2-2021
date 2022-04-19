provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# backend
terraform {
  backend "s3" {
    bucket  = "...s3 bucket name..."
    encrypt = true
    key     = "...key path..."
    region  = "ap-northeast-2"
  }
}

module "vpc" {
  source             = "../../module/vpc"
  name               = var.name
  environment        = var.environment
  availability_zones = var.availability_zones
  cidr               = var.cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  bastion_nat_ids    = module.bastion.bastion_nat_ids
}

# security group
module "security_groups" {
  source               = "../../module/securitygroup"
  name                 = var.name
  environment          = var.environment
  vpc_id               = module.vpc.id
  database_port        = var.database_port
  office_cidr          = var.office_cidr
  private_subnets      = var.private_subnets
}

module "bastion" {
  source              = "../../module/bastion"
  name                = var.name
  environment         = var.environment
  instance_type       = var.ec2_t2_micro_type
  availability_zones  = var.availability_zones
  public_subnet_ids          = module.vpc.public_subnet_ids
  bastion_security_group_ids = module.security_groups.bastion_sg_ids
  ssh_pub_key                = file("${var.bastion_key_path}")
}

module "backend" {
  source              = "../../module/backend"
  name                = var.name
  environment         = var.environment
  instance_type       = var.ec2_t2_micro_type
  ami                 = var.amazon_linux_ami
  availability_zones  = var.availability_zones
  private_subnet_ids         = module.vpc.private_subnet_ids
  backend_security_group_ids = module.security_groups.backend_sg_ids
  ssh_pub_key                = file("${var.backend_key_path}")
}

# application loab balancer
module "alb" {
  source              = "../../module/alb"
  name                = var.name
  environment         = var.environment
  vpc_id              = module.vpc.id
  backend_ids         = module.backend.backend_ids
  public_subnet_ids   = module.vpc.public_subnet_ids
  alb_sg_ids          = module.security_groups.alb_sg_ids
  health_check_path   = var.health_check_path
  alb_tls_cert_arn    = var.tsl_certificate_arn
  domain_name         = var.domain_name
  alb_bucket_id       = module.s3.alb_bucket_id
  listener_rule_key   = var.listener_rule_key
  listener_rule_values= var.environment
}

module "s3" {
  source              = "../../module/s3"
  name                = var.name
  environment         = var.environment
  alb_account_id      = var.alb_account_id
}

# CodeDeploy
module "codedeploy" {
  source              = "../../module/codedeploy"
  name                = var.name
  environment         = var.environment
  #autoscaling_groups  = ["autoscaling1", "autoscaling2"]   
  ec2_tag_filter      = {Name = "${var.environment}-backend-*"} 
}

# RDS
module "rds" {
  source                 = "../../module/rds"
  name                   = var.name
  environment            = var.environment
  rds_pg_family          = var.rds_pg_family
  rds_allocated_storage  = var.rds_allocated_storage
  rds_max_storage        = var.rds_max_storage
  rds_engine             = var.rds_engine
  rds_engine_version     = var.rds_engine_version
  rds_instance_class     = var.rds_instance_class
  rds_storage_type       = var.rds_storage_type
  rds_security_group_ids = module.security_groups.rds_sg_ids
  database_name          = var.database_name
  database_user          = var.database_user
  database_password      = var.database_password
  private_subnet_ids     = module.vpc.private_subnet_ids
}
