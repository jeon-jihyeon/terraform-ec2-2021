provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# backend
terraform {
  backend "s3" {
    bucket  = "...s3 bucket name..."
    encrypt = true
    key     = "...key path..."
    region  = "ap-northeast-2"
  }
}
