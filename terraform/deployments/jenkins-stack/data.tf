################################################################################
# Availability zone info
################################################################################
data "aws_availability_zones" "azs" {
}


################################################################################
# AWS latest ubuntu ami
################################################################################

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
}