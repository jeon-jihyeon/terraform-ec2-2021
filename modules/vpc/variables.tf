variable "name" {
  description = "the name of service"
}

variable "environment" {
  description = "the name of environment, e.g. \"prod\""
}

variable "cidr" {
  description = "the cidr block for the VPC."
}

variable "public_subnets" {
  description = "list of public subnets"
}

variable "private_subnets" {
  description = "list of private subnets"
}

variable "availability_zones" {
  description = "list of availability zones"
}

variable "bastion_nat_ids" {
  description = "list of bastion nat id"
}
