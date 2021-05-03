
data "aws_iam_policy_document" "codepipeline-react-image-compressor-assume-role-document" {
  statement {
    sid = "AllowAssume"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }

}

resource "aws_iam_role" "codepipeline-react-image-compressor-role" {
  assume_role_policy  = data.aws_iam_policy_document.codepipeline-react-image-compressor-assume-role-document.json
  name                = "${local.app_id}-codepipeline-role"
}


data "aws_iam_policy_document" "codepipeline-react-image-compressor-role-policy-document" {
  statement {
    sid       = "AllowS3Access"
    effect    = "Allow"
    actions   = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    resources = [
      aws_s3_bucket.react-image-compressor-artifacts.arn
    ]

  }
  statement {
    sid       = "AllowECRAccess"
    effect    = "Allow"
    actions   = [
      "ecr:DescribeImages",
      "ecr:GetImages"
    ]
    resources = [
      aws_ecr_repository.react-image-compressor.arn
    ]
  }
  statement {
    sid         = "AllowCodeBuildAccess"
    effect      = "Allow"
    actions     = [
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds"
    ]
    resources   = [
      aws_codebuild_project.react-image-compressor.arn
    ]
  }
}

resource "aws_iam_role_policy" "codepipeline-react-image-compressor-role-policy" {
  policy    = data.aws_iam_policy_document.codepipeline-react-image-compressor-role-policy-document.json
  role      = aws_iam_role.codepipeline-react-image-compressor-role.id
}
