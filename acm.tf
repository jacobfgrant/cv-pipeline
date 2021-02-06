### ACM Certificates & Validations ###

# ACM Certificate
resource "aws_acm_certificate" "cv_distribution_cert" {
  provider = aws.east

  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = local.tags_map

  lifecycle {
    create_before_destroy = true
  }
}


# ACM Cert Validation
resource "aws_acm_certificate_validation" "cv_cert" {
  provider = aws.east

  certificate_arn         = aws_acm_certificate.cv_distribution_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cv_cert_validation : record.fqdn]
}
