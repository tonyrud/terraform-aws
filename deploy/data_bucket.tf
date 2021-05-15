resource "aws_s3_bucket" "data" {
  bucket = local.bucket
  acl    = "private"

  tags = local.common_tags
}