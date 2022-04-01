# Output regestry id
output "account_id" {
  value = data.aws_ecr_repository.ecr_repository.registry_id
}
# Output URL of registry
output "registry_url" {
  value = data.aws_ecr_repository.ecr_repository.repository_url
}
