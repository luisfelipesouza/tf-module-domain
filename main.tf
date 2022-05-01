resource "aws_route53_zone" "hosted_zone" {
  name          = "${var.domain}."
  comment       = "Domain for ${var.application} in ${var.environment}"
  force_destroy = true

  tags = {
    Name          = lower("${var.application}-${var.environment}")
    environment   = lower(var.environment)
    application   = lower(var.application)
    cost-center   = lower(var.cost-center)
    deployed-by   = lower(var.deployed-by)
  }
}

resource "aws_route53_record" "ns_records" {
  allow_overwrite = true
  name            = var.domain
  ttl             = 30
  type            = "NS"
  zone_id         = aws_route53_zone.hosted_zone.zone_id

  records = [
    aws_route53_zone.hosted_zone.name_servers[0],
    aws_route53_zone.hosted_zone.name_servers[1],
    aws_route53_zone.hosted_zone.name_servers[2],
    aws_route53_zone.hosted_zone.name_servers[3],
  ]
}