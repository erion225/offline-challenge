
################################################################################
# Route Tables and Associations
################################################################################
resource "aws_route_table" "public_route_tables" {
  for_each = var.public_subnets
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.internet_gateway.id
  }

  tags = var.tags
}

resource "aws_route_table" "private_route_tables" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[each.key].id
  }

  tags = var.tags
}


resource "aws_route_table_association" "public_route_table_association" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public_route_tables[each.key].id
}

resource "aws_route_table_association" "private_route_table_association" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_route_tables[each.key].id
}