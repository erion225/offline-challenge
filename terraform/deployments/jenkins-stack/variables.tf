variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  validation {
    condition     = anytrue([can(regex("10(?:\\.(?:[0-1]?[0-9]?[0-9])|(?:2[0-5]?[0-9])){3}\\/", var.vpc_cidr)), can(regex("172\\.(?:3?[0-1])|(?:[0-2]?[0-9])(?:\\.[0-2]?[0-5]?[0-9]){2}\\/(?:1[6-9]|2[0-9]|3[0-2])", var.vpc_cidr))])
    error_message = "Must be a valid Private IPv4 CIDR block address."
  }
}

variable "public_subnet1_cidr" {
  description = "The IPv4 CIDR block for the public subnet1."
  type        = string
  validation {
    condition     = anytrue([can(regex("10(?:\\.(?:[0-1]?[0-9]?[0-9])|(?:2[0-5]?[0-9])){3}\\/", var.public_subnet1_cidr)), can(regex("172\\.(?:3?[0-1])|(?:[0-2]?[0-9])(?:\\.[0-2]?[0-5]?[0-9]){2}\\/(?:1[6-9]|2[0-9]|3[0-2])", var.public_subnet1_cidr))])
    error_message = "Must be a valid Private IPv4 CIDR block address."
  }
}

variable "private_subnet1_cidr" {
  description = "The IPv4 CIDR block for the private subnet1."
  type        = string
  validation {
    condition     = anytrue([can(regex("10(?:\\.(?:[0-1]?[0-9]?[0-9])|(?:2[0-5]?[0-9])){3}\\/", var.private_subnet1_cidr)), can(regex("172\\.(?:3?[0-1])|(?:[0-2]?[0-9])(?:\\.[0-2]?[0-5]?[0-9]){2}\\/(?:1[6-9]|2[0-9]|3[0-2])", var.private_subnet1_cidr))])
    error_message = "Must be a valid Private IPv4 CIDR block address."
  }
}

variable "stack_name" {
  description = "Identify and differentiate resource stacks"
  type        = string
}

variable "environment" {
  description = "environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3.medium"
}

variable "asg_min_size" {
  description = "Autoscaling group minimum size"
  type        = number
  default     = 1
  validation {
    condition     = var.asg_min_size >= 0 && var.asg_min_size <= 1
    error_message = "Minimum size of ASG can be only either 0 or 1"
  }
}
variable "asg_max_size" {
  description = "Autoscaling group maximum size"
  type        = number
  default     = 1
  validation {
    condition     = var.asg_max_size >= 0 && var.asg_max_size <= 2
    error_message = "Maximum size of autoscaling group can be only either 0 or 2"
  }
}

variable "instance_port" {
  type        = number
  description = "Instance port"
}

variable "load_balancer_port" {
  type        = number
  description = "Load balancer frontend port"
}