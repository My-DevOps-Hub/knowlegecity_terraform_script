output "primary_write_endpoint" {
  description = "Primary cluster write endpoint"
  value       = aws_rds_cluster.primary.endpoint
}

output "primary_reader_endpoint" {
  description = "Primary cluster reader endpoint"
  value       = aws_rds_cluster.primary.reader_endpoint
}

output "secondary_reader_endpoint" {
  description = "Secondary cluster reader endpoint"
  value       = aws_rds_cluster.secondary.reader_endpoint
}
