################################################################################
# NETWORK VARS
################################################################################
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "subnet ids"
  type        = list(string)
  default     = []
}

variable "allowed_security_groups" {
  description = "List of Security Group IDs permitted to access EFS mounts"
  type        = list(string)
  default     = []
}

variable "allowed_cidrs" {
  description = "List of CIDRs permitted to access EFS mounts"
  type        = list(string)
  default     = []
}

################################################################################
# EFS PERFORMANCE AND ENCRYPTION CONFIG VARS
################################################################################
variable "performance_mode" {
  description = "Performance mode to run in (`generalPurpose` or `maxIO`). See https://aws.amazon.com/premiumsupport/knowledge-center/linux-efs-performance-modes/ for details."
  type        = string
  default     = "generalPurpose"
}

variable "provisioned_throughput" {
  description = "Provisioned throughput (in mbps)"
  type        = number
  default     = null
}

variable "throughput_mode" {
  description = "EFS file system throughput mode (`provisioned` or `bursting`)"
  type        = string
  default     = "bursting"
}

variable "efs_kms_key_id" {
  description = "ARN of KMS key to use for EFS encryption (leave null to create a key, set to `aws/backup` to use AWS default CMK)"
  type        = string
  default     = null
}

################################################################################
# APPLICATION VARS
################################################################################
variable "environment" {
  description = "Name of the environment"
  type        = string
}
variable "stack_name" {
  description = "application name used with in resource names"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


locals {
  create_sg_rule      = length(var.allowed_security_groups) > 0 ? true : false
  create_sg_cidr_rule = length(var.allowed_cidrs) > 0 ? true : false
}