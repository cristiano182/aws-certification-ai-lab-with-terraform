terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-dev-1746926346063"
    dynamodb_table = "terraform-state-table-lock"
    encrypt        = true
  }
}