### Route 53 Records ###

# Route 53 Alias Record
resource "aws_route53_record" "cv" {
  zone_id = var.route_53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cv_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cv_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}


# Route 53 Cert Validation
resource "aws_route53_record" "cv_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cv_distribution_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = var.route_53_zone_id
  records = [each.value.record]
  ttl     = 60
}
