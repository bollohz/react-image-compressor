
terraform {
  required_version = ">= 0.12.15"
}

provider "aws" {
  region = var.region
}

locals {
  app_id = "${var.environment_name}_${var.app_name}"
  tags = merge(var.base_tags,
    {

    }
  )
}
