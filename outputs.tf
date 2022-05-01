output "hosted_zone_id" {
  value = aws_route53_zone.hosted_zone.id
}
output "domain" {
  value = var.domain
}
output "ns_record" {
  value = aws_route53_record.ns_records.records
}