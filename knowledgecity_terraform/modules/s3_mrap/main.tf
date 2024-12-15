resource "aws_s3control_multi_region_access_point" "this" {
  details {
    name = var.mrap_name

    region {
      bucket = var.primary_bucket_arn
    }

    region {
      bucket = var.secondary_bucket_arn
    }
  }
}

