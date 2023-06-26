################################################################################
# NETWORKING INFO
################################################################################

data "aws_subnets" "subnets" {
  tags = var.subnets_tags_filter
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

################################################################################
# IAM TRUST RELATIONSHIP
################################################################################

data "aws_iam_policy_document" "trust_relationship_policy" {
  statement {
    sid = "AssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

