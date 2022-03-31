remote_state {
  backend = "s3"
  config = {
    bucket         = "${local.app_name}-${local.env}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
  }
}

locals {
    env = "prod"
    region = "us-east-2"
    app_name = "password-generator"
    account_id = "000000000000"
}

inputs = {
    env = local.env
    region = local.region
    app_name = local.app_name
    account_id = local.account_id
}