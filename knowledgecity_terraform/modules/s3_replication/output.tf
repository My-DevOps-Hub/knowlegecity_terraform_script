output "primary_bucket_id" {
  description = "ID of the primary S3 bucket"
  value       = aws_s3_bucket.primary.id
}

output "secondary_bucket_id" {
  description = "ID of the secondary S3 bucket"
  value       = aws_s3_bucket.secondary.id
}
