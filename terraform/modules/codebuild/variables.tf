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


# Variables from another modules
# ECR module
# Get AWS account id
variable "account_id" {
  description = "AWS account ID"
  type        = string
}
# ECR Registri URL
variable "registry_url" {
  description = "Default ECR registry URL"
  type        = string
}

# Clustem module (Network)
# VPC id
variable "vpc_id" {
  description = "Default VPC id from Network module"
  type        = string
}
# Private subnet id (list of subnets)
variable "subnets_id" {
  description = "Default list of subnets id from Network module"
  type        = list(any)
}
# Cluster module (ECS)
# Name of task definition family
variable "task_definition_family" {
  description = "Name of task definition"
  type        = string
}
# Name of task definition cluster
variable "task_definition_cluster" {
  description = "Name of ECS cluster"
  type        = string
}
# Name of task definition service
variable "task_definition_service" {
  description = "Name of ECS service"
  type        = string
}

# s3 module
# Name of s3 for codebuild
variable "s3_arn_codebuild" {
  description = "Name of s3 bucket"
  type        = string
}


