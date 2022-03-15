output "bastion_nat_ids" {
  description = "list of bastion instance id"
  value       = aws_instance.bastion.*.id
}

output "bastion_eip_ids" {
 description = "list of bastion instance eip"
 value       = aws_eip.bastion.*.id
}