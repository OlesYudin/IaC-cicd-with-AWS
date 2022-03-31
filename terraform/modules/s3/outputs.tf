# Ouput url of s3 bucket for codebuild
output "s3_url_codebuild" {
  value = aws_s3_bucket.codebuild_cache.bucket_regional_domain_name
}
# Ouput arn of s3 bucket for codebuild
output "s3_arn_codebuild" {
  value = aws_s3_bucket.codebuild_cache.arn
}
