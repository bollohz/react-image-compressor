
data "aws_iam_policy_document" "codebuild-react-image-compress-assume-role-document" {
  statement {
    sid     = "AllowCodeBuildAssumeRole"
    effect  = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
  }
}


data "aws_iam_policy_document" "codebuild-react-image-compress-policy-document" {
  statement {
    sid     = "AllowCloudwatchLogs"
    effect  = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid     = "AllowECRGetToken"
    effect  = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid     = "AllowECRImageManagement"
    effect  = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = [
      aws_ecr_repository.react-image-compressor.arn
    ]
  }
  statement {
    sid     = "AllowS3forArtifacts"
    effect  = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.react-image-compressor-artifacts.arn
    ]
  }
}


resource "aws_iam_role" "codebuild-react-image-compressor-role" {
  assume_role_policy  = data.aws_iam_policy_document.codebuild-react-image-compress-assume-role-document.json
  name                = "${local.app_id}-codebuild-role"
}

resource "aws_iam_role_policy" "codebuild-react-image-compressor-policy" {
  policy  = data.aws_iam_policy_document.codebuild-react-image-compress-policy-document.json
  role    = aws_iam_role.codebuild-react-image-compressor-role.id
}
