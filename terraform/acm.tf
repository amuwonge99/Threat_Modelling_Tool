# ACM Certificate for the Application Domain
resource "aws_acm_certificate" "app" {
  domain_name               = local.domain
  subject_alternative_names = ["www.${local.domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}