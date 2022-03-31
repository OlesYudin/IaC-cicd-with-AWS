terraform {
    source = "../../../modules//ecr"
}
include {
  path = find_in_parent_folders()
}
# This module depends on s3
dependencies {
  paths = ["../s3"]
}