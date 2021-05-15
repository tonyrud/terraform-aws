terraform {
  required_version = ">= 0.12"

  # must create in AWS before running any TF commands
  backend "s3" {
    bucket         = "326347646211-standard-data-tfstate"
    key            = "standard-data/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "standard-data-tfstate-lock"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}