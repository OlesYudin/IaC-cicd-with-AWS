# Security group for ALB
resource "aws_security_group" "sg_ecs_alb" {
  name        = "SG-HTTP"
  description = "Security group for ALB and ECS"
  vpc_id      = aws_vpc.vpc.id

  # Inbound rules for app port
  ingress {
    description = "HTTP for ALB and ECS"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name        = "SG-HTTP-ALB-ECS-${var.env}"
    Environment = var.env
  }
}
