variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  type        = string
  default     = "standard-data"
  description = "Base prefix for all resources"
}

variable "project" {
  type    = string
  default = "standard-data-app"
}