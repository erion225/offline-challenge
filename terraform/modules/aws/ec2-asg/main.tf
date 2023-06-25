################################################################################
# EC2 Security Group
################################################################################

resource "aws_security_group" "sg_main" {
  name_prefix = "${var.stack_name}-${var.environment}-sg"
  vpc_id      = var.vpc_id
  description = "${var.environment} security group in ${var.stack_name} env"

  tags = {
    Name = "${var.stack_name}-${var.environment}-sg"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# EC2 Security Group INGRESS RULES
################################################################################

resource "aws_security_group_rule" "ingress_rules_from_sg" {
  count                    = length(local.ingress_rules_from_sg)
  description              = "Allow security group ${local.ingress_rules_from_sg[count.index][0]} to communicate with port ${local.ingress_rules_from_sg[count.index][1]}"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_main.id
  source_security_group_id = local.ingress_rules_from_sg[count.index][0]
  from_port                = local.ingress_rules_from_sg[count.index][1]
  to_port                  = local.ingress_rules_from_sg[count.index][1]
  type                     = "ingress"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group_rule" "ingress_rules_from_cidrs" {
  count             = length(local.ingress_rules_from_cidr)
  description       = "Allow CIDR ${local.ingress_rules_from_cidr[count.index][0]} to communicate with port ${local.ingress_rules_from_cidr[count.index][1]}"
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_main.id
  cidr_blocks       = [local.ingress_rules_from_cidr[count.index][0]]
  from_port         = local.ingress_rules_from_cidr[count.index][1]
  to_port           = local.ingress_rules_from_cidr[count.index][1]
  type              = "ingress"

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# IAM INSTANCE ROLE AND POLICY
################################################################################
resource "aws_iam_role" "iam_role" {
  name_prefix = "${var.stack_name}-${var.environment}-infra"
  description = "${var.environment} Instance role"

  assume_role_policy    = data.aws_iam_policy_document.trust_relationship_policy.json
  path                  = "/"
  force_detach_policies = true

  managed_policy_arns = concat([aws_iam_policy.default_iam_policy.arn], var.extra_iam_policies)
}

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "default_iam_policy" {
  name_prefix = "${var.stack_name}-${var.environment}"
  description = "${var.environment} Policy for ${var.stack_name} env"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "ssm:DescribeAssociation",
            "ssm:GetDeployablePatchSnapshotForInstance",
            "ssm:GetDocument",
            "ssm:DescribeDocument",
            "ssm:GetManifest",
            "ssm:ListAssociations",
            "ssm:ListInstanceAssociations",
            "ssm:PutInventory",
            "ssm:PutComplianceItems",
            "ssm:PutConfigurePackageResult",
            "ssm:UpdateAssociationStatus",
            "ssm:UpdateInstanceAssociationStatus",
            "ssm:UpdateInstanceInformation"
        ],
        "Resource": "*"
     },
    {
        "Effect": "Allow",
        "Action": [
            "ec2messages:AcknowledgeMessage",
            "ec2messages:DeleteMessage",
            "ec2messages:FailMessage",
            "ec2messages:GetEndpoint",
            "ec2messages:GetMessages",
            "ec2messages:SendReply"
        ],
        "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.stack_name}-${var.environment}-instance-profile"
  role = aws_iam_role.iam_role.name
}

################################################################################
# AWS LAUNCH TEMPLATE
################################################################################

resource "aws_launch_template" "launch_template" {
  name_prefix            = "${var.stack_name}-${var.environment}-launch-template"
  description            = "${var.environment} launch template"
  image_id               = var.ami_id
  vpc_security_group_ids = [aws_security_group.sg_main.id]
  instance_type          = var.instance_type
  metadata_options {
    http_tokens = "required"
  }
  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile.arn
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.stack_name}-${var.environment}"
    }
  }
  user_data = base64encode(var.user_data)

  ebs_optimized = true
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", null) == null ? [] : ["ebs"]
        content {
          delete_on_termination = lookup(block_device_mappings.value.ebs, "delete_on_termination", null)
          encrypted             = lookup(block_device_mappings.value.ebs, "encrypted", null)
          iops                  = lookup(block_device_mappings.value.ebs, "iops", null)
          kms_key_id            = lookup(block_device_mappings.value.ebs, "kms_key_id", null)
          snapshot_id           = lookup(block_device_mappings.value.ebs, "snapshot_id", null)
          volume_size           = lookup(block_device_mappings.value.ebs, "volume_size", null)
          volume_type           = lookup(block_device_mappings.value.ebs, "volume_type", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# AWS AUTOSCALING GROUP
################################################################################

resource "aws_autoscaling_group" "autoscaling_group" {
  name_prefix         = "${var.stack_name}-${var.environment}-autoscaling-group"
  desired_capacity    = var.desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = data.aws_subnets.subnets.ids

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}