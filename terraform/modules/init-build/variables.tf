# Default region
variable "region" {
  description = "Default region"
  type        = string
}
# Application name
variable "app_name" {
  description = "Default Application name"
  type        = string
}
# Port for App
variable "app_port" {
  description = "Default Application port"
  type        = number
}
# Docker image tag
variable "image_tag" {
  description = "Default Docker image tag"
  type        = string
}
# Working app dir
variable "app_working_dir" {
  description = "Defaulr Working app dir"
  type        = string
}

# Repository id in ECR
variable "account_id" {
  description = "Repository id in ECR"
  type        = string
}
# Repository URL in ECR
variable "registry_url" {
  type = string
}
