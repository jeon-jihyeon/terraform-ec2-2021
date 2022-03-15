variable "name" {
  description = "the name of service"
}

variable "environment" {
  description = "the name of environment, e.g. \"prod\""
}

variable "instance_type" {
  description = "bastion EC2 instance type"
}

variable "availability_zones" {
  description = "bastion EC2 instance availability zone"
}

variable "public_subnet_ids" {
  description = "list of public subnet id"
}

variable "bastion_security_group_ids" {
  description = "list of Security Group ids"
}

variable "ssh_pub_key" {
  description = "public key for ssh"
}