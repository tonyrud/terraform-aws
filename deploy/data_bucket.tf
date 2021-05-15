resource "aws_s3_bucket" "data" {
  bucket = local.bucket
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  tags = local.common_tags
}