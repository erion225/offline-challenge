
################################################################################
# EC2 SECURITY GROUP FOR EFS
################################################################################

resource "aws_security_group" "efs_security_group" {

  name_prefix = "${var.environment}-${var.stack_name}-efs-sg"
  description = "${var.environment} SG for access to elastic file system"
  vpc_id      = var.vpc_id

  tags = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# EC2 SECURITY GROUP INGRESS RULES FOR EFS
################################################################################

resource "aws_security_group_rule" "allow_security_groups_to_access_efs" {
  count = local.create_sg_rule ? length(var.allowed_security_groups) : 0

  description              = "SG ${var.allowed_security_groups[count.index]} permitted access to EFS mounts"
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs_security_group.id
  source_security_group_id = var.allowed_security_groups[count.index]
  to_port                  = 2049
  type                     = "ingress"
}

resource "aws_security_group_rule" "allow_cidrs_to_access_efs" {
  count = local.create_sg_cidr_rule ? length(var.allowed_cidrs) : 0

  description       = "SG ${var.allowed_cidrs[count.index]} permitted access to EFS mounts"
  from_port         = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.efs_security_group.id
  cidr_blocks       = [var.allowed_cidrs[count.index]]
  to_port           = 2049
  type              = "ingress"
}

################################################################################
# EFS FILE SYSTEM
################################################################################

resource "aws_efs_file_system" "file_system" {
  encrypted                       = true
  kms_key_id                      = var.efs_kms_key_id
  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.throughput_mode == "provisioned" ? var.provisioned_throughput : null
  tags                            = var.tags
}

################################################################################
# EFS MOUNT TARGETS
################################################################################

resource "aws_efs_mount_target" "file_system_mount_target" {
  count           = length(var.subnets) > 0 ? length(var.subnets) : 0
  file_system_id  = aws_efs_file_system.file_system.id
  security_groups = [aws_security_group.efs_security_group.id]
  subnet_id       = var.subnets[count.index]
}