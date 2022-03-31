# Application
# Default region where will be created infrastructure
variable "region" {
  description = "Default region"
  type        = string
}
# Default environments
variable "env" {
  description = "Default environment"
  type        = string
}
# Name of container for App (Docker)
variable "app_name" {
  description = "Default application name"
  type        = string
}

# SNS
# SNS endpoint
variable "sns_endpoint" {
  description = "Destination address for subsribe"
  type        = string
}

# Variables for another modules
variable "codebuild_project_name" {} # Name of CodeBuild project to attach to CloudWatch
variable "codebuild_project_arn" {}  # ARN of CodeBuild
