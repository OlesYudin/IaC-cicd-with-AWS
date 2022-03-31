resource "aws_security_group" "codebuild" {
  name   = "${var.app_name}-${var.env}-codebuild"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "SG-CodeBuild-${var.env}-${var.app_name}"
    Environment = var.env
  }
}
