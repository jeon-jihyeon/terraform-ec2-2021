variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "backend_ids" {
  description = "List of Backend Instance ID"
}

variable "public_subnet_ids" {
  description = "Comma separated list of subnet IDs"
}

variable "alb_sg_ids" {
  description = "Comma separated list of alb_sg_ids"
}

variable "health_check_path" {
  description = "Path to check if the service is healthy, e.g. \"/status\""
}

variable "alb_tls_cert_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}

variable "domain_name" {
  description = "domain name"
}

variable "alb_bucket_id" {
  description = "id of alb log bucket"
}

variable "listener_rule_key" {
  description = "listener rule key"
}

variable "listener_rule_values" {
  description = "list of listener rule value"
}
