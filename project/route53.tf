##

data "aws_route53_zone" "mysmh" {
  name         = "mysmh.co.in"
  private_zone = false
}

resource "aws_route53_zone" "private_rds" {
  name = "rds.com"
  vpc {
    vpc_id = aws_vpc.three_tier_vpc.id
  }

  tags = {
    Name = "rds-private-hosted-zone"
  }
}

resource "aws_route53_record" "book" {
  zone_id = aws_route53_zone.private_rds.zone_id
  name    = "book.rds.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.rds_instance.address]
}

resource "aws_route53_record" "syed" {
  zone_id = data.aws_route53_zone.mysmh.zone_id
  name    = "syed.mysmh.co.in"
  type    = "A"
  alias {
    name                   = aws_lb.back_alb.dns_name
    zone_id                = aws_lb.back_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.mysmh.zone_id
  name    = "frontend.mysmh.co.in"
  type    = "A"
  alias {
    name                   = aws_lb.front_alb.dns_name
    zone_id                = aws_lb.front_alb.zone_id # Corrected
    evaluate_target_health = true
  }
}
