# ACM Certificate for the Application Domain
resource "aws_acm_certificate" "app" {
  domain_name               = trimsuffix(var.domain_name, ".")
  validation_method         = "DNS"
  subject_alternative_names = ["www.${trimsuffix(var.domain_name, ".")}"]

  lifecycle {
    create_before_destroy = true
  }
}
##########################################################################

# ACM DNS Validation
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.app.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.main.zone_id

  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]

  allow_overwrite = true
}
##################################################################

# ACM Certificate Validation
resource "aws_acm_certificate_validation" "app" {
  certificate_arn = aws_acm_certificate.app.arn

  validation_record_fqdns = [
    for record in aws_route53_record.cert_validation :
    record.fqdn
  ]
}