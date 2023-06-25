################################################################################
# Create virtual network
################################################################################
module "network" {
  source   = "../../modules/aws/vpc"
  vpc_name = "${var.stack_name}-${var.environment}-01"
  vpc_cidr = var.vpc_cidr
  public_subnets = {
    "${var.stack_name}-subnet-1" = {
      "cidr"  = var.public_subnet1_cidr
      "az_id" = data.aws_availability_zones.azs.zone_ids[0]
      "tags" = {
        "zone" = "public",
        "tier" = "external"
      }
    }
  }
  private_subnets = {
    "${var.stack_name}-subnet-1" = {
      "cidr"  = var.private_subnet1_cidr
      "az_id" = data.aws_availability_zones.azs.zone_ids[0]
      "tags" = {
        "zone" = "private",
        "tier" = "internal"
      }
    }
  }
  tags = {
    "stack_name"  = var.stack_name,
    "environment" = var.environment
  }
}

################################################################################
# Create application storage
################################################################################
module "storage" {
  source        = "../../modules/aws/efs"
  vpc_id        = module.network.vpc_id
  stack_name    = var.stack_name
  environment   = var.environment
  allowed_cidrs = module.network.private_subnets_cidr_blocks
  subnets       = module.network.private_subnets
}

################################################################################
# Create infrastructure and deploy application
################################################################################
module "application" {
  depends_on = [module.storage]
  source     = "../../modules/aws/ec2-asg"
  vpc_id     = module.network.vpc_id
  subnets_tags_filter = {
    "zone" = "private"
  }
  instance_type = var.instance_type
  asg_min_size  = var.asg_min_size
  asg_max_size  = var.asg_max_size
  stack_name    = var.stack_name
  environment   = var.environment
  ami_id        = data.aws_ami.amazon-linux-2.id
  user_data     = templatefile("${path.module}/templates/userdata.tpl", { EFS_ID = module.storage.efs-server-id })
}

################################################################################
# Create Load Balancer
################################################################################
module "loadbalancer" {
  depends_on         = [module.application]
  source             = "../../modules/aws/elb"
  name               = "${var.stack_name}-${var.environment}-elb"
  vpc_id             = module.network.vpc_id
  subnets            = module.network.public_subnets
  asg_id             = module.application.autoscaling_group_id
  instance_port      = var.instance_port
  load_balancer_port = var.load_balancer_port
  tags = {
    "stack_name"  = var.stack_name,
    "environment" = var.environment
  }
}

################################################################################
# Allow traffic between load balancer and application
################################################################################
resource "aws_security_group_rule" "elb_to_app" {
  security_group_id        = module.application.security_group_id
  source_security_group_id = module.loadbalancer.security_group_id
  description              = "Allow ingress on port 8080 from Loadbalancer to application"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}