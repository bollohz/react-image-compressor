
resource "aws_codepipeline" "codepipeline-react-image-compressor-project" {
  name = "${local.app_id}-pipeline"
  role_arn = aws_iam_role.codepipeline-react-image-compressor-role.arn

  artifact_store {
    location = aws_s3_bucket.react-image-compressor-artifacts.id
    type = "S3"
  }

  stage {
    name        = "RepoSource"
    action {
      category  = "Source"
      name      = "Source"
      owner     = "ThirdParty"
      provider  = "GitHub"
      version   = "1"
      configuration = {
        Owner       = var.github_owner,
        Repo        = var.github_repositoryname,
        Branch      = var.target_branch,
        OAuthToken  = var.github_token
      }

      output_artifacts = [
        "RepoArtifact"
      ]
    }
  }

  stage {
    name        = "BuildApp"
    action {
      category  = "Build"
      name      = "BuildApp"
      owner     = "AWS"
      provider  = "CodeBuild"
      version   = "1"
      input_artifacts   = ["RepoArtifact"]
      output_artifacts  = ["BuildArtifact"]

      configuration = {
        ProjectName     = aws_codebuild_project.react-image-compressor.name
      }
    }
  }

}
