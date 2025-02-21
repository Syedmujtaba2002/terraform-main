resource "aws_s3_bucket" "dev" {
  bucket = var.name
  acl = var.acl
}