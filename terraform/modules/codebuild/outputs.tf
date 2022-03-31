# Output CodeBuild name
output "codebuild_project_name" {
  value = aws_codebuild_project.password-generator-codebuild-plan.name
}
# Output CodeBuild arn
output "codebuild_project_arn" {
  value = aws_codebuild_project.password-generator-codebuild-plan.arn
}
