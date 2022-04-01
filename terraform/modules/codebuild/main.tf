# CodeBuild Project
resource "aws_codebuild_project" "password-generator-codebuild-plan" {
  name                   = "Password-generator-${var.env}-codebuild-plan"
  description            = "CodeBuild project for password generator application"
  build_timeout          = "5"
  service_role           = aws_iam_role.codebuild-iam-role.arn
  concurrent_build_limit = 1 # Run only 1 build (Cant run 2 ore more build in case of 2 or more commit)

  # Артефакты, которые можно хранить в S3 bucket в качестве архива 
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL" # Free 100minutes of build per month
    # Image can take from official Terraform Docker image, your custom Docker image or from this official AWS:
    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    image = "aws/codebuild/standard:4.0"
    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html
    type                        = "LINUX_CONTAINER" # ARM container use general1.small image type
    image_pull_credentials_type = "CODEBUILD"       # Type of credentials AWS CodeBuild uses to pull images in your build
    privileged_mode             = true              # All command in pipeline will run with sudo

    environment_variable {
      name  = "ENV"
      value = var.env
    }
    environment_variable {
      name  = "AWS_REGION"
      value = var.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }
    environment_variable {
      name  = "ECR_APP_URL"
      value = var.registry_url
    }
    environment_variable {
      name  = "TASK_DEFINITION_FAMILY"
      value = var.task_definition_family
    }
    environment_variable {
      name  = "TASK_DEFINITION_CLUSTER"
      value = var.task_definition_cluster
    }
    environment_variable {
      name  = "TASK_DEFINITION_SERVICE"
      value = var.task_definition_service
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_url
    buildspec       = var.buildspec
    git_clone_depth = 1

    report_build_status = "true" # Whether to report the status of a build's start and finish to your source provider.
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.subnets_id
    security_group_ids = [aws_security_group.codebuild.id]
  }

  tags = {
    Environment = var.env
  }

  depends_on = [
    aws_iam_role.codebuild-iam-role,
    aws_ssm_parameter.ssm-github-auth
  ]
}

# AWS Pipeline
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook
# Manages a CodeBuild webhook, which is an endpoint accepted by the CodeBuild service 
# to trigger builds from source code repositories. Depending on the source type of the CodeBuild project, 
# the CodeBuild service may also automatically create and delete the actual repository webhook as well.
resource "aws_codebuild_webhook" "password-generator-webhook" {
  project_name = aws_codebuild_project.password-generator-codebuild-plan.name
  build_type   = "BUILD"

  filter_group {
    filter {
      type    = "EVENT"
      pattern = var.github_pattern
    }
    filter {
      type    = "HEAD_REF"
      pattern = var.github_branch
    }
  }
}
# Create resource for store secrets (GitHub OAuthToken)
resource "aws_ssm_parameter" "ssm-github-auth" {
  name        = "GitHubAuth-${var.app_name}-${var.env}"
  description = "Github token for codebuild auth"
  type        = "SecureString"
  value       = var.github_credential

  tags = {
    name = "GitHubAuth"
    env  = var.env
  }
}
# Connect Auth token to CodeBuild
resource "aws_codebuild_source_credential" "github-auth-credential" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = aws_ssm_parameter.ssm-github-auth.value
}
