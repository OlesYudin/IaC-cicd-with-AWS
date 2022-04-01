terraform {
    source = "../../../modules//init-build"
}
include {
  path = find_in_parent_folders()
}

dependency "ecr" {
  config_path = "../ecr"
  # Get outputs from module ECR
  mock_outputs = {
    account_id = "000000000000"
    registry_url = "0000000000000.dkr.ecr.us-east-2.amazonaws.com/app"
  }
}
locals {
  # List variables for initialise application store in: $TERRAGRUNT_ROOT_DIR/dev/variables/app_var.hcl
  app_var = read_terragrunt_config(find_in_parent_folders("variables/app_var.hcl"))
}
inputs = {
  app_name = local.app_var.locals.app_name
  app_port = local.app_var.locals.app_port
  image_tag = local.app_var.locals.image_tag
  app_working_dir = local.app_var.locals.app_working_dir
  account_id = dependency.ecr.outputs.account_id # Get account ID
  registry_url = dependency.ecr.outputs.registry_url
}

# This module depends on ECR
dependencies {
  paths = ["../ecr"]
}