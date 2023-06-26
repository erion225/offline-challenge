################################################################################
# NETWORK VARS
################################################################################
variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs"
}

################################################################################
# AUTOSCALING GROUP CONFIG VARS
################################################################################
variable "asg_id" {
  type        = string
  description = "ID of the Auto Scaling Group"
}

################################################################################
# APPLICATION CONFIG VARS
################################################################################
variable "name" {
  type        = string
  description = "Name of the resources"
}

variable "instance_port" {
  type        = number
  description = "Instance port"
}

variable "load_balancer_port" {
  type        = number
  description = "Load balancer frontend port"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resources"
}