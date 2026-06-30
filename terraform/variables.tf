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
