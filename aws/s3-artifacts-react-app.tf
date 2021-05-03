resource "aws_s3_bucket" "react-image-compressor-artifacts" {
  bucket        = "react-image-compressor-artifacts"
  acl           = "private"
  force_destroy = false
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = merge(local.tags, {
  })
}

resource "aws_s3_bucket_public_access_block" "external_services_pipeline_artifact_repo_public_access" {
  bucket                  = aws_s3_bucket.react-image-compressor-artifacts.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
