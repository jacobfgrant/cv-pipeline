### S3 Buckets & Policies ###

# S3 Bucket
resource "aws_s3_bucket" "cv_bucket" {
  bucket        = var.cv_bucket
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = var.s3_versioning_enabled
  }

  tags = local.tags_map
}


# S3 Bucket Policy
resource "aws_s3_bucket_policy" "cv_s3_bucket_policy" {
  bucket = aws_s3_bucket.cv_bucket.id
  policy = data.aws_iam_policy_document.cv_s3_bucket_policy_document.json
}
