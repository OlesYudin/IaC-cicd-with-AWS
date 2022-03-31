# Application Load Balancer
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "alb" {
  name               = "ALB-${var.env}"
  internal           = false         # default
  load_balancer_type = "application" # type of load balancer
  security_groups    = [aws_security_group.sg_ecs_alb.id]
  subnets            = aws_subnet.public_subnet.*.id
  ip_address_type    = "ipv4" # IP addres type (Can be IPv4 or dual)
  # enable_deletion_protection = false

  tags = {
    Name        = "ALB-${var.env}-${var.app_name}"
    Environment = var.env
  }
}

# Target group for ALB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "alb_target" {
  name        = "TG-ALB-${var.env}"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  # add HTTP2 only

  # Health check for target group
  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "3"
    interval            = "60"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "30"
    path                = "/"
  }

  tags = {
    Name        = "ALB-TG-${var.env}"
    Environment = var.env
  }
}

# ALB listener
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_target.arn
    type             = "forward"
  }

  tags = {
    Name        = "ALB-Listener-80-${var.env}-${var.app_port}"
    Listen      = "HTTP-80"
    Environment = var.env
  }
}
