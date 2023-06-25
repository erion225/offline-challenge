output "efs-server-arn" {
  description = "ARN of the EFS file system"
  value       = aws_efs_file_system.file_system.arn
}

output "efs-server-id" {
  description = "ID of the EFS file system"
  value       = aws_efs_file_system.file_system.id
}

output "efs-server-dns-endpoint" {
  description = "DNS endpoint of the EFS file system"
  value       = aws_efs_file_system.file_system.dns_name
}

output "efs_security_group_id" {
  description = "ID of the security group associated with the EFS file system"
  value       = aws_security_group.efs_security_group.id
}
