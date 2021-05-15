locals {
  prefix = "${var.prefix}-${terraform.workspace}"

  account_id = data.aws_caller_identity.current.account_id

  bucket = "${local.account_id}-${var.prefix}-${terraform.workspace}"

  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    ManagedBy   = "Terraform"
  }

  lambda_env_vars = {
    BUCKET = local.bucket
    REGION = var.aws_region
  }
}