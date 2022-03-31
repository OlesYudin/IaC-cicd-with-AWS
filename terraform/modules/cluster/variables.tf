# ECS and ECR
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
variable "image_tag" {
  description = "Image tag for application"
  type        = string
}
# Container repository
variable "registry_url" {
  description = "URL of repository that will push to ECS"
  type        = string
}
# Size of CPU for ECS Cluster
variable "ecs_container_cpu" {
  description = "Count of ECS Cluster desired"
  type        = number
}
# Size of Memory for ECS Cluster
variable "ecs_container_memory" {
  description = "Count of ECS Cluster desired"
  type        = number
}
# Count of ECS Cluster desired
variable "ecs_desired_count" {
  description = "Count of ECS Cluster desired"
  type        = number
}

# Network
# Default VPC CIDR
variable "cidr_vpc" {
  description = "CIDR of VPC"
  type        = string
}
# Default public subnets for VPC
variable "public_subnet" {
  description = "Public CIDR-block for subnets"
  type        = list(string)
}
# Default private subnets for VPC
variable "private_subnet" {
  description = "Private CIDR-block for subnets"
  type        = list(string)
}
# Default CIDR for routing traffic
variable "default_cidr" {
  description = "Default CIDR block for IN/OUT traffic"
  type        = string
}

# SG
# Port for Application (ALB)
variable "app_port" {
  description = "Default application port"
  type        = number
}
