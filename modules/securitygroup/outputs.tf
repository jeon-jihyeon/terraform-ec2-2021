output "alb_sg_ids" {
  value = aws_security_group.alb.*.id
}

output "bastion_sg_ids" {
  value = [aws_security_group.bastion.id]
}

output "backend_sg_ids" {
  value = [aws_security_group.backend.id]
}

output "rds_sg_ids" {
  value = [aws_security_group.rds.id]
}