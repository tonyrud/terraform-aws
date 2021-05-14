terraform {
  required_version = ">= 0.12"

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

locals {
  prefix = "${var.prefix}-${terraform.workspace}"

  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}