output "iam_user_name" {
  description = "Name of the created IAM user"
  value       = aws_iam_user.bedrock_local_dev.name
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
