terraform {
    source = "../../../modules//codebuild"
}
include {
  path = find_in_parent_folders()
}

# Get outputs from module ECR
dependency "ecr" {
  config_path = "../ecr"
  mock_outputs = {
    account_id = "000000000000"
    registry_url = "000000000000.dkr.ecr.us-east-2.amazonaws.com/image"
  }
}
# Get outputs from module CLUSTER
dependency "cluster" {
  config_path = "../cluster"
  mock_outputs = {
    # Network
    vpc_id = "vpc-000000000000"
    subnets_id = [
      "subnet-33333333333333333",
      "subnet-44444444444444444"
    ]
    # ECS
    task_definition_family = "task-definition-family"
    task_definition_cluster = "task-definition-cluster"
    task_definition_service = "task-definition-service"
  }
}
# Get outputs from module s3
dependency "s3" {
  config_path = "../s3"
  mock_outputs = {
    s3_arn_codebuild = "password-generator-prod-codebuild"
  }
}

locals {  
  # List variables for github (owner, url, cred, etc.) in: $TERRAGRUNT_ROOT_DIR/dev/variables/github_var.hcl
  github_var = read_terragrunt_config(find_in_parent_folders("variables/github_var.hcl"))
}
inputs = {
  # Github variables
  github_credential = local.github_var.locals.github_credential
  github_owner = local.github_var.locals.github_owner
  github_url = local.github_var.locals.github_url
  github_source_brance = local.github_var.locals.github_source_brance
  github_branch = local.github_var.locals.github_branch
  github_pattern = local.github_var.locals.github_pattern
  github_trigger_path = local.github_var.locals.github_trigger_path

  # Buildspec path
  buildspec = local.github_var.locals.buildspec

  # ECR variables
  account_id              = dependency.ecr.outputs.account_id                  # Get account ID
  registry_url            = dependency.ecr.outputs.registry_url                # ECR registy URL

  # Network variables
  vpc_id = dependency.cluster.outputs.vpc_id # VPC id
  subnets_id = dependency.cluster.outputs.subnets_id # Subnets is (Lis of subnets)
  
  # ECS variables
  task_definition_family  = dependency.cluster.outputs.task_definition_family  # Name of task definition 
  task_definition_cluster = dependency.cluster.outputs.task_definition_cluster # Name of ECS cluster
  task_definition_service = dependency.cluster.outputs.task_definition_service # Name of ECS service
  
  # s3 variables
  s3_arn_codebuild = dependency.s3.outputs.s3_arn_codebuild # s3 ARN
}

# This module depends on cluster
dependencies {
  paths = ["../cluster"]
}