terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-dev-1746926346063"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-table-lock-dev"
    encrypt        = true
  }
}