resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }

  tags = {
    Name = "app-cert"
  }
}

# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }

#   zone_id = module.route53.hosted_zone_id
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
# }

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
}