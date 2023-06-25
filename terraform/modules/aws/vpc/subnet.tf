
################################################################################
# Publiс Subnets
################################################################################
resource "aws_subnet" "public" {
  for_each             = var.public_subnets
  availability_zone_id = each.value.az_id
  cidr_block           = each.value.cidr
  vpc_id               = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "public-${each.key}" },
    var.tags,
    each.value.tags
  )
}

################################################################################
# Private Subnets
################################################################################
resource "aws_subnet" "private" {
  for_each             = var.private_subnets
  availability_zone_id = each.value.az_id
  cidr_block           = each.value.cidr
  vpc_id               = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "private-${each.key}" },
    var.tags,
    each.value.tags
  )
}
