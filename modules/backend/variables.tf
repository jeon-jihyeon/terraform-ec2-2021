variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "instance_type" {
  description = "backend EC2 instance type"
}

variable "ami" {
  description = "backend AMI"
}

variable "availability_zones" {
  description = "backend EC2 instance availability zone"
}

variable "private_subnet_ids" {
  description = "List of private_subnet_ids"
}

variable "backend_security_group_ids" {
  description = "List of Security Group ids"
}

variable "ssh_pub_key" {
  description = "Public key for ssh"
}