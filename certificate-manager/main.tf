resource "aws_acm_certificate" "dev_proj_1_acm_arn" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.dev_proj_1_acm_arn.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.hosted_zone_id # replace with your Hosted Zone ID
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}


resource "aws_acm_certificate_validation" "dev_proj_1_acm_arn" {
  certificate_arn         = aws_acm_certificate.dev_proj_1_acm_arn.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
  #validation_record_fqdns = ["${aws_route53_record.validation.fqdn}"]


  timeouts {
    create = "120m"
  }
}




/*resource "aws_acm_certificate" "dev_proj_1_acm_arn" {
  domain_name       = var.domain_name
  validation_method = "EMAIL"

  tags = {
    Environment = "production"
  }
}

resource "aws_acm_certificate_validation" "dev_proj_1_acm_arn" {
  certificate_arn         = aws_acm_certificate.dev_proj_1_acm_arn.arn

  # Since validation is done via email, no DNS validation records are required
  # validation_record_fqdns is not needed here

  timeouts {
    create = "120m"
  }
}*/
