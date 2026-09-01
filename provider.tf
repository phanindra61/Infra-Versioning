terraform {
  required_version = ">= 1.7.0"

  backend "s3" {
    bucket         = "infra-versioning-stateful-bucket"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
