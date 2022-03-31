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
