output "backend_ids" {
  description = "Bastion EC2 instance ID list"
  value       = aws_instance.backend.*.id
}

output "backend_eip_ids" {
  description = "backend EIP ID list"
  value       = aws_eip.backend.*.id
}

output "backend_iam_role_arn" {
  description = "backend IAM Role ARN"
  value       = aws_iam_role.backend.arn
}