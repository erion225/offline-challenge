
output "security_group_id" {
  value       = aws_security_group.sg_main.id
  description = "Security group ID"
}

output "autoscaling_group_id" {
  value       = aws_autoscaling_group.autoscaling_group.id
  description = "Autoscaling group ID"
}

output "subnets" {
  value       = data.aws_subnets.subnets.ids
  description = "Autoscaling group ID"
}