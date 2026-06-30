terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_region" {
  description = "AWS region used by the AWS provider"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile Terraform uses to authenticate (e.g. your SSO profile)"
  type        = string
  default     = null
}

variable "iam_user_name" {
  description = "Name of the IAM user created for local Bedrock access"
  type        = string
  default     = "bedrock-local-dev"
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
        Effect = "Allow"
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream",
        ]
        Resource = [
          "arn:aws:bedrock:*::foundation-model/*",
          "arn:aws:bedrock:*:*:inference-profile/*",
        ]
      }
    ]
  })
}

resource "aws_iam_access_key" "bedrock_local_dev" {
  user = aws_iam_user.bedrock_local_dev.name
}

output "access_key_id" {
  description = "AWS_ACCESS_KEY_ID value for the project's .env"
  value       = aws_iam_access_key.bedrock_local_dev.id
}

output "secret_access_key" {
  description = "AWS_SECRET_ACCESS_KEY value for the project's .env"
  value       = aws_iam_access_key.bedrock_local_dev.secret
  sensitive   = true
}
