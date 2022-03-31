# S3 bucker for codebuild
resource "aws_s3_bucket" "codebuild_cache" {
  bucket = "${var.app_name}-${var.env}-codebuild"
  acl    = "private"
  # Enable versioning in bucket
  versioning {
    enabled = true
  }
  # S3 policy for delete
  lifecycle_rule {
    id      = "Delete after 3 days"
    enabled = true
    expiration {
      days = 3
    }
  }

  tags = {
    Name        = "${var.app_name}-${var.env}-codebuild"
    Environment = var.env
    Region      = var.region
  }
}
