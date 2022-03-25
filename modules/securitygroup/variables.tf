variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "office_cidr" {
  description = "bastion ingress cidr block"
}

variable "database_port" {
  description = "database port"
}

variable "private_subnets" {
  description = "List of private subnets"
}