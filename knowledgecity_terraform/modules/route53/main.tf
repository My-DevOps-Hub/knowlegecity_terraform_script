# CNAME Record for Primary Write Endpoint
resource "aws_route53_record" "this" {
  zone_id = var.private_hosted_zone_id
  name    = var.cname_record_name
  type    = "CNAME"
  ttl     = 60
  records = [var.db_endpoint]
}

