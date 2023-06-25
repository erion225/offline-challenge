################################################################################
# NETWORK RELATED VARS
################################################################################
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "subnets_tags_filter" {
  description = "filter to fetch subnet ids"
  type        = map(string)
}
variable "ingress_security_groups" {
  description = "List of Security Groups that are allowed to access the application"
  type        = list(string)
  default     = []
}
variable "ingress_cidr_blocks" {
  description = "CIDRs to allow ingress"
  type        = list(string)
  default     = []
}
variable "ingress_ports" {
  description = "TCP Ports to allow access"
  type        = list(string)
  default     = []
}

################################################################################
# CAPACITY RELATED VARS
################################################################################
variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
}
variable "asg_min_size" {
  description = "Autoscaling group minimum size"
  type        = number
  default     = 1
}
variable "asg_max_size" {
  description = "Autoscaling group maximum size"
  type        = number
  default     = 1
}
variable "desired_capacity" {
  description = "Autoscaling group desired capacity"
  type        = number
  default     = "1"
}
variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"

  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))

  default = []
}

################################################################################
# APPLICATION CONFIG RELATED VARS
################################################################################
variable "stack_name" {
  description = "Name of the environment"
  type        = string
}
variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "environment" {
  description = "application name used with in resource names"
  type        = string
}
variable "extra_iam_policies" {
  description = "List of additional IAM policies to grant access to EC2 instance"
  type        = list(string)
  default     = []
}
variable "user_data" {
  description = "User data for launch template configuration"
  type        = string
}
locals {
  ingress_rules_from_sg   = setproduct(var.ingress_security_groups, var.ingress_ports)
  ingress_rules_from_cidr = setproduct(var.ingress_cidr_blocks, var.ingress_ports)
}