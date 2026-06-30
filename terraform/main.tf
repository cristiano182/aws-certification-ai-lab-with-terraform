terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_iam_user" "bedrock_local_dev" {
  name = var.iam_user_name
  path = "/"

  tags = {
    Project = "simple-lambda-app"
    Purpose = "Local development access to AWS Bedrock"
  }
}

resource "aws_iam_user_policy" "bedrock_invoke" {
  name = "${var.iam_user_name}-bedrock-invoke"
  user = aws_iam_user.bedrock_local_dev.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "InvokeBedrockModels"
        Effect = "Allow"
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream",
        ]
        Resource = [
          "arn:aws:bedrock:*::foundation-model/*",
          "arn:aws:bedrock:*:*:inference-profile/*",
        ]
      },
      {
        Sid      = "ListBedrockModels"
        Effect   = "Allow"
        Action   = "bedrock:ListFoundationModels"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "bedrock_local_dev" {
  user = aws_iam_user.bedrock_local_dev.name
}
