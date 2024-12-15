output "mrap_alias" {
  description = "Alias for the Multi-Region Access Point"
  value       = aws_s3control_multi_region_access_point.this.alias
}