terraform {
  required_version = ">= 0.14"
}

provider "aws" {
    region = "us-east-1"
}

data "aws_iam_policy_document" "kai_s3_policy_doc" {
  statement {
    sid = "KaiS3ReadOnly"
    actions = [
      "s3:List*",
      "s3:Get*"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
  statement {
    sid = "KaiS3Write"
    actions = [
      "s3:Create*",
      "s3:Update*",
      "s3:Delete*",
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

resource "aws_iam_policy" "kai_s3_policy" {
  name = "kai_s3_policy"
  path = "/"
  policy = data.aws_iam_policy_document.kai_s3_policy_doc.json
}