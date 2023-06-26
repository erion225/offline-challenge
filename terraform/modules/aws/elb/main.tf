################################################################################
# Loadbalancer Security Group
################################################################################

resource "aws_security_group" "elb" {
  name        = "${var.name}-elb-sg"
  vpc_id      = var.vpc_id
  description = "Load Balancer Security group"

  tags = var.tags

  ingress {
    protocol    = "tcp"
    from_port   = var.load_balancer_port
    to_port     = var.load_balancer_port
    description = "allow traffic to from internet"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    description = "allow traffic egress"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# Loadbalancer and Autoscaling group attachment
################################################################################

resource "aws_elb" "elb" {
  name                        = "${var.name}-elb"
  subnets                     = var.subnets
  internal                    = false
  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 30
  security_groups             = [aws_security_group.elb.id]

  listener {
    instance_port     = var.instance_port
    instance_protocol = "http"
    lb_port           = var.load_balancer_port
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 10
    target              = "TCP:${var.instance_port}"
    interval            = 20
  }
  tags = var.tags
}

resource "aws_autoscaling_attachment" "autoscaling_group" {
  autoscaling_group_name = var.asg_id
  elb                    = aws_elb.elb.id
}