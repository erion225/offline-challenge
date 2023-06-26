################################################################################
# Terraform version and backend configuration
################################################################################
terraform {
  required_version = ">= 1.3.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}