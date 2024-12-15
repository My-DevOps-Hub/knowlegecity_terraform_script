output "zone_id" {
  description = "ID of the private hosted zone"
  value       = aws_route53_zone.private_zone.zone_id
}