terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-1746926346063"
    dynamodb_table = "terraform-state-table-lock"
    encrypt        = true
  }
}