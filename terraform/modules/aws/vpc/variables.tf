################################################################################
# NETWORK VARS
################################################################################
variable "vpc_name" {
  description = "Name to be used as identifier for vpc"
  type        = string
}

variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = "A map of objects where each key is the name of the subnet and each value is an object representing public subnet configuration"
  type = map(object({
    cidr  = string
    az_id = string
    tags  = optional(map(string))
  }))
}

variable "private_subnets" {
  description = "A map of objects where each key is the name of the subnet and each value is an object representing private subnet configuration"
  type = map(object({
    cidr  = string
    az_id = string
    tags  = optional(map(string))
  }))
}

################################################################################
# APPLICATION CONFIG VARS
################################################################################
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}