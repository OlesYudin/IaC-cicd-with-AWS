terraform {
    source = "../../../modules//s3"
}
include {
  path = find_in_parent_folders()
}