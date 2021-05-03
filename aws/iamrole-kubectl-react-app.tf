
data "aws_iam_policy_document" "codebuild-kubectl-assume-role-document" {
  statement {
    sid = "AllowAssume"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_id}:root"
      ]
    }
  }

}

resource "aws_iam_role" "codebuild-kubectl-role" {
  assume_role_policy  = data.aws_iam_policy_document.codebuild-kubectl-assume-role-document.json
  name                = "${local.app_id}-kubectl-iam-role"
}


data "aws_iam_policy_document" "codebuild-kubectl-role-policy-document" {
  statement {
    sid = "AllowEKSDescribe"
    effect = "Allow"
    actions = [
      "eks:Describe*",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild-kubectl-role-policy" {
  policy    = data.aws_iam_policy_document.codebuild-kubectl-role-policy-document.json
  role      = aws_iam_role.codebuild-kubectl-role.id
}
