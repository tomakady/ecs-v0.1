data "aws_route53_zone" "domain" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "app_record" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = false
  }

  ttl = 300

}