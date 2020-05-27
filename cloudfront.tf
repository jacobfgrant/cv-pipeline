### CloudFront Distribution ###

# Local Values
locals {
  s3_origin_id            = "CV_S3_Bucket"
  cloudfront_cnames       = compact([var.domain_name])
}


# CloudFront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "cv_distribution_identity" {
  comment = "CloudFront origin access identity for CV"
}


# CloudFront Distribution
resource "aws_cloudfront_distribution" "cv_distribution" {
  origin {
    domain_name = aws_s3_bucket.cv_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    origin_path = "/cv-pipeline"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cv_distribution_identity.cloudfront_access_identity_path
    }
  }

  enabled             = var.enable_cloudfront
  retain_on_delete    = var.cloudfront_retain_on_delete
  wait_for_deployment = var.cloudfront_wait_for_deployment

  comment             = "CloudFront distribution for CV pipeline."
  is_ipv6_enabled     = true
  default_root_object = var.pipeline_output_object

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.cv_bucket.bucket_domain_name
    prefix          = "logs/cloudfront/"
  }

  aliases = local.cloudfront_cnames

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 604800
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.cv_distribution_cert.arn
    minimum_protocol_version       = "TLSv1.2_2018"
    ssl_support_method             = "sni-only"
  }

  tags = local.tags_map

  depends_on = [
    aws_acm_certificate.cv_distribution_cert,
    aws_acm_certificate_validation.cv_cert
  ]
}
