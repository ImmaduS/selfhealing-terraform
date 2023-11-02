terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key = "./terraform.tfstate "
    region = "us-east-2"
    dynamodb_table = "my-lock-table"
    encrypt = true
  }
}