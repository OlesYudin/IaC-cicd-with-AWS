# <div align="center">Password generator application</div>

In this repository you can find project, that create infrastructure for AWS cloud provider using tarrafrom and terragrunt tool.

## Project tools

- [`Terraform`](https://www.terraform.io/ "Terraform") as a tool for IaC
- [`Terrgrunt`](https://terragrunt.gruntwork.io/ "Terrgrunt") as a wrapper for terraform
- [`AWS`](https://aws.amazon.com/ru/ "AWS") as cloud provider
  - [`ECR`](https://aws.amazon.com/ru/ecr/ "ECR") as registry for docker image
  - [`ECS`](https://aws.amazon.com/ru/ecs/ "ECS") as a service for for working application
  - [`CodeBuild`](https://aws.amazon.com/ru/codebuild/ "AWS CodeBuild") as a tool for CI\CD integration
  - [`s3`](https://aws.amazon.com/ru/s3/ "s3") as a service for storage remote state for terraform
- [`GitHub`](https://github.com/ "GitHub") as SCM service

## Environment

- [`dev`](https://github.com/OlesYudin/demo_4/tree/main/terraform/env/dev "dev") - test configuration for developer
- [`prod`](https://github.com/OlesYudin/demo_4/tree/main/terraform/env/prod "prod") - configuration for production

## Modules

- [`s3`](https://github.com/OlesYudin/demo_4/tree/main/terraform/modules/s3 "s3") - module for creating s3 bucket. Bucket can be use as place for storage archive of codepipeline
- [`ecr`](https://github.com/OlesYudin/demo_4/tree/main/terraform/modules/ecr "ecr") - module that create ECR repository for storage docker images
- [`init-build`](https://github.com/OlesYudin/demo_4/tree/main/terraform/modules/init-build "init-build") - module thar create local initial docker image and push it to AWS ECR
- [`cluster`](https://github.com/OlesYudin/demo_4/tree/main/terraform/modules/cluster "cluster") - module that create Network infrastructure and ECS fargate cluster for web-application
- [`codebuild`](https://github.com/OlesYudin/demo_4/tree/main/terraform/modules/codebuild "codebuild") - module that create CD in project (run new ECS cluster after developer make change in application)
- [`sns`](https://github.com/OlesYudin/demo_4/tree/main/terraform/modules/sns "sns") - module that create notification after codebuild finish deploying new cluster (FOR FUTURE, NOW NOT WORKING)

## Variables

- [`app_var.hcl`](https://github.com/OlesYudin/demo_4/blob/main/terraform/env/dev/variables/app_var.hcl "app_var.hcl") - variables for application
- [`ecs_var.hcl`](https://github.com/OlesYudin/demo_4/blob/main/terraform/env/dev/variables/ecs_var.hcl "ecs_var.hcl") - variables for ECS fargate cluster
- [`github_var.hcl`](https://github.com/OlesYudin/demo_4/blob/main/terraform/env/dev/variables/github_var.hcl "github_var.hcl") - variables for configuration github repository
- [`network_var.hcl`](https://github.com/OlesYudin/demo_4/blob/main/terraform/env/dev/variables/network_var.hcl "network_var.hcl") - variables for netwotk in cluster
- [`sns_var.hcl`](https://github.com/OlesYudin/final_demo/blob/main/terraform/env/dev/variables/sns_var.hcl "sns_var.hcl") - variables for SNS

Link to variables show for example in [dev](https://github.com/OlesYudin/demo_4/tree/main/terraform/env/dev/variables "dev") environment, but you can find variables for prod environment in this [link](https://github.com/OlesYudin/demo_4/tree/main/terraform/env/prod "link")

## Network scheme

<p align="center">
  <img src="https://github.com/OlesYudin/demo_4/blob/main/images/network-infrastructure.jpg" alt="Scheme of network"/>
</p>

## Initial build

<p align="center">
  <img src="https://github.com/OlesYudin/demo_4/blob/main/images/init-build.png" alt="Scheme of network"/>
</p>

## CI/CD scheme

<p align="center">
  <img src="https://github.com/OlesYudin/demo_4/blob/main/images/ci-cd.png" alt="Scheme of network"/>
</p>

## Application

Single page application (SPA) that generate pseudo random password that can be use as a password for different social network

| Option | Value                                                                                            |
| ------ | ------------------------------------------------------------------------------------------------ |
| OS     | Alpine Linux v3.15                                                                               |
| PHP    | v7.2                                                                                             |
| Port   | HTTP (80)                                                                                        |
| Image  | [Docker hub](https://hub.docker.com/repository/docker/olesyudin/password-generator "Docker hub") |
