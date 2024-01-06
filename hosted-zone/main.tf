data "aws_route53_zone" "dev_proj_1_omilabs_com" {
  name         = "omilabs.com"
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.dev_proj_1_omilabs_com.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.aws_lb_dns_name
    zone_id                = var.aws_lb_zone_id
    evaluate_target_health = true
    #region = var.aws_lb_zone_id
  }
}


