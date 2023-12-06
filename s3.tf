### S3 Buckets & Policies ###

# S3 Bucket
resource "aws_s3_bucket" "cv_bucket" {
  bucket        = var.cv_bucket
  force_destroy = true

  tags = local.tags_map
}


# S3 Bucket ACL
resource "aws_s3_bucket_acl" "cv_bucket" {
  bucket = aws_s3_bucket.cv_bucket.id
  acl    = "private"
}


# S3 Bucket Policy
resource "aws_s3_bucket_policy" "cv_s3_bucket_policy" {
  bucket = aws_s3_bucket.cv_bucket.id
  policy = data.aws_iam_policy_document.cv_s3_bucket_policy_document.json
}


# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "cv_bucket" {
  bucket = aws_s3_bucket.cv_bucket.id
  versioning_configuration {
    status = var.s3_versioning_enabled
  }
}
