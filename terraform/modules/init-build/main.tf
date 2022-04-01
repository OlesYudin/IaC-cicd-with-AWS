# Init build Application
resource "null_resource" "init_build_container" {
  provisioner "local-exec" {
    command     = "sh docker.sh"
    working_dir = var.app_working_dir
    # Environment variables for script
    environment = {
      region       = var.region
      account_id   = var.account_id
      registry_url = var.registry_url
      image_tag    = var.image_tag
    }
  }
}

