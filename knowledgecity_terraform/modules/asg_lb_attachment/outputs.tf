output "autoscaling_attachment_id" {
  description = "The ID of the autoscaling attachment."
  value       = aws_autoscaling_attachment.this.id
}
