# # TFstate s3
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "tfstate-demo-tfstate-s3-${var.env}"
#   # Enable versioning
#   versioning {
#     enabled = true
#   }
#   # Enable server-side encryption by default
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
# }
# # Block public access S3 bucket
# # This policy need for security storage of S3 bucket and now this policy like:
# # 1. Cant switch bucket to public with ACL policy;
# # 2. Cant switch bucket to publick using bucket policy;
# # 3. Cant keep object with public access in this bucket;
# resource "aws_s3_bucket_public_access_block" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   block_public_acls       = true # Block public ACLs for bucket (PUT Object calls will fail if the request includes an object ACL)
#   block_public_policy     = true # Block public bucket policies for bucket (Reject calls to PUT Bucket policy if the specified bucket policy allows public access)
#   ignore_public_acls      = true # Ignore public ACLs for this bucket and any objects that it contains
#   restrict_public_buckets = true # Restrict public bucket policies for this bucket (Only the bucket owner and AWS Services can access this buckets if it has a public policy)
# }
# # DynamoDB lock for tfstate
# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "demo-dynamodb-lock-${var.env}"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
