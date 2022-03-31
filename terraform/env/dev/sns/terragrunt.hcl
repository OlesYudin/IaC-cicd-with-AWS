terraform {
    source = "../../../modules//sns"
}
include {
  path = find_in_parent_folders()
}

# Get outputs from module s3
dependency "codebuild" {
  config_path = "../codebuild"
  mock_outputs = {
    codebuild_project_name = "password-generator-dev-codebuild-plan"
    codebuild_project_arn = "arn:aws:codebuild:us-east-2:000000000000:project/Application-name-env-codebuild-plan"
  }
}

locals {  
  # List variables for github (owner, url, cred, etc.) in: $TERRAGRUNT_ROOT_DIR/dev/variables/github_var.hcl
  sns_var = read_terragrunt_config(find_in_parent_folders("variables/sns_var.hcl"))
}
inputs = {
    # Codebuild variables
    codebuild_project_name =  dependency.codebuild.outputs.codebuild_project_name
    codebuild_project_arn =  dependency.codebuild.outputs.codebuild_project_arn

    # SNS variables
    sns_endpoint = local.sns_var.locals.sns_endpoint
}

# This module depends on cluster
dependencies {
  paths = ["../codebuild"]
}