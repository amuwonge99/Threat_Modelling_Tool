# Route53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = trimsuffix(var.domain_name, ".")
}
####################################################################

# Route53 Record for the root domain
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name = trimsuffix(var.domain_name, ".")
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}

####################################################################

# Route53 Record for the www subdomain
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${trimsuffix(var.domain_name, ".")}"
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}