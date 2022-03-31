terraform {
    source = "../../../modules//cluster"
}
include {
  path = find_in_parent_folders()
}

dependency "ecr" {
  config_path = "../ecr"
  # Get outputs from module ECR
  mock_outputs = {
    registry_url = "000000000000.dkr.ecr.us-east-2.amazonaws.com/image"
  }
}
locals {
  # List variables for application store in: $TERRAGRUNT_ROOT_DIR/dev/variables/app_var.hcl
  app_var = read_terragrunt_config(find_in_parent_folders("variables/app_var.hcl"))
  # List variables for network (VPC) store in: $TERRAGRUNT_ROOT_DIR/dev/variables/network_var.hcl
  network_var = read_terragrunt_config(find_in_parent_folders("variables/network_var.hcl"))
  # List variables for ECS Cluster store in: $TERRAGRUNT_ROOT_DIR/$ENV/variables/ecs_var.hcl
  ecs_var = read_terragrunt_config(find_in_parent_folders("variables/ecs_var.hcl"))
}
inputs = {
  # Network variables (VPC)
  cidr_vpc = local.network_var.locals.cidr_vpc
  public_subnet = local.network_var.locals.public_subnet
  private_subnet = local.network_var.locals.private_subnet
  default_cidr = local.network_var.locals.default_cidr
  
  # Security Group variables
  app_port = local.app_var.locals.app_port

  # Variables for ECS cluster
  app_name = local.app_var.locals.app_name
  image_tag = local.app_var.locals.image_tag
  registry_url = dependency.ecr.outputs.registry_url # URL of repository
  ecs_container_cpu = local.ecs_var.locals.ecs_container_cpu
  ecs_container_memory = local.ecs_var.locals.ecs_container_memory
  ecs_desired_count = local.ecs_var.locals.ecs_desired_count
}
# This module depends on ECR module
dependencies {
  paths = ["../init-build"]
}