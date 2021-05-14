variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  type        = string
  default     = "standard-data"
  description = "Base prefix for all Terraform resources"
}

variable "project" {
  type    = string
  default = "standard-data-app"
}

variable "lambda_runtime" {
  type    = string
  default = "nodejs12.x"
}

variable "api_resources" {
  type        = object({ breeds = string })
  description = "Names for API resources"

  default = {
    breeds = "breeds"
  }
}