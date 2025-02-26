variable "s3_buckets" {
  type    = list(string)
  default = [ "bacfgfjgkup-bucket", "lofghhgs-bucket"]
}

resource "aws_s3_bucket" "dev" {
  for_each = toset(var.s3_buckets)  # Convert list to a set to use for_each
  bucket   = each.value
}
