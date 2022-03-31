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


# Gihub variables for codebuild
# Github credentials that stored in Parameter Store
variable "github_credential" {
  description = "Github credentials (OAuth)"
  type        = string
}
# Owner of github account
variable "github_owner" {
  description = "Owner of Github account"
  type        = string
}
# Default github url repository
variable "github_url" {
  description = "Github url repository"
  type        = string
}
# Default branch where will aplly some commit 
variable "github_source_brance" {
  description = "Github branch for trigger commit"
  type        = string
}
# Default branch for start codebuild if something commit 
variable "github_branch" {
  description = "Github branch for trigger commit"
  type        = string
}
# Default if someone pull request to branch
variable "github_pattern" {
  description = "Default action for codebuild (PUSH, PULL REQUEST, etc..)"
  type        = string
}
# Default path where will be do changes
variable "github_trigger_path" {
  description = "Default path where will be do changes"
  type        = string
}


# Codebuild
variable "buildspec" {
  description = "Buildspec.yml path"
  type        = string
}
variable "account_id" {}              # Get AWS account id
variable "registry_url" {}            # ECR Registri URL
variable "task_definition_family" {}  # Name of task definition family
variable "task_definition_cluster" {} # Name of task definition cluster
variable "task_definition_service" {} # Name of task definition service
variable "s3_arn_codebuild" {}        # Name of s3 for codebuild


