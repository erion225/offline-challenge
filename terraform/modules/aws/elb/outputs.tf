output "elb_dns_name" {
  value       = aws_elb.elb.dns_name
  description = "DNS name of the Elastic Load Balancer"
}

output "security_group_id" {
  value       = aws_security_group.elb.id
  description = "ID of the Load Balancer Security Group"
}

output "autoscaling_attachment_id" {
  value       = aws_autoscaling_attachment.autoscaling_group.id
  description = "ID of the Auto Scaling Attachment"
}