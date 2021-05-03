locals {
  log_group_name  = "/aws/codebuild/${local.app_id}-codebuild-project"
}

resource "aws_codebuild_source_credential" "react-image-compressor-source-credential" {
  auth_type = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token = var.github_token
}

resource "aws_codebuild_project" "react-image-compressor" {
  name            = local.app_id
  description     = "CodeBuild project in order to build and deploy React Image Compressor"
  build_timeout   = "60"
  service_role    = aws_iam_role.codebuild-react-image-compressor-role.arn
  source_version  = var.target_branch
  source {
    type            = "GITHUB"
    location        = var.repository_location
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = true
    }
    auth {
      resource = aws_codebuild_source_credential.react-image-compressor-source-credential.id
      type = "PERSONAL_ACCESS_TOKEN"
    }
    buildspec   = file("templates/react-image-compressor-buildspec.yml")
  }

  artifacts {
    type            = "S3"
    path            = "artifacts"
    name            = "ReactImageCompressorArtifact"
    packaging       = "ZIP"
    namespace_type  = "NONE"
    location        = aws_s3_bucket.react-image-compressor-artifacts.id
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:3.0"
    type            = "LINUX_CONTAINER"

    environment_variable {
      name = "REPOSITORY_URI"
      value = aws_ecr_repository.react-image-compressor.repository_url
    }
    environment_variable {
      name = "KUBECTL_ROLE"
      value = aws_iam_role.codebuild-kubectl-role.arn
    }
    environment_variable {
      name = "$REPOSITORY_BRANCH"
      value = var.target_branch
    }
  }

  tags = merge(local.tags, {
  })
  logs_config {
    cloudwatch_logs {
      group_name  = local.log_group_name
      status      = "ENABLED"
    }
  }
}

resource "aws_cloudwatch_log_group" "react-image-compressor-codebuild-log" {
  name              = local.log_group_name
  retention_in_days = "30"
  tags = merge(local.tags, {
  })
}
