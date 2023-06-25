
################################################################################
# Internet Gateway
################################################################################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = var.tags
}

################################################################################
# NAT Gateway
################################################################################
resource "aws_eip" "nat_ip" {
  for_each = var.public_subnets
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gateways" {
  for_each      = var.public_subnets
  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.nat_ip[each.key].id

  tags = var.tags
}
