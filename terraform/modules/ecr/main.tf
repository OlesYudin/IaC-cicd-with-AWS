# Create ECR repository
resource "aws_ecr_repository" "ecr_repository" {
  name = var.app_name
  #   image_tag_mutability = "IMMUTABLE" # If immutable you cant write to same tag in 1 repo

  image_scanning_configuration {
    scan_on_push = false
  }
}

# Create Lifecycle policy for ECR repository
# Delete all build more than 3
resource "aws_ecr_lifecycle_policy" "test_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repository.name

  policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Keep only 3 images",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 3
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}

# Output information about ECR repository
data "aws_ecr_repository" "ecr_repository" {
  name       = var.app_name # Get name of ECR repo for output info about this repository
  depends_on = [aws_ecr_repository.ecr_repository]
}
