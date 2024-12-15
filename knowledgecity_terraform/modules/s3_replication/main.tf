resource "aws_s3_bucket" "primary" {
  provider = aws.us_east_1
  bucket   = var.primary_bucket_name
  acl      = "private"
  versioning {
    enabled = true
  }

  tags = {
    Name        = var.primary_bucket_name
    Environment = "dev"
  }
}

resource "aws_s3_bucket" "secondary" {
  provider = aws.us_west_1
  bucket   = var.secondary_bucket_name
  acl      = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = var.secondary_bucket_name
    Environment = "dev"
  }
}

# IAM Role for replication
resource "aws_iam_role" "s3_replication_role" {
  name = "s3-replication-role-${var.primary_bucket_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

# IAM Policy for replication
resource "aws_iam_policy" "s3_replication_policy" {
  name        = "s3-replication-policy-${var.primary_bucket_name}"
  description = "Policy to allow replication between S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.primary.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.primary.bucket}/*",
          "arn:aws:s3:::${aws_s3_bucket.secondary.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.secondary.bucket}/*"
        ]
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_replication_policy" {
  policy_arn = aws_iam_policy.s3_replication_policy.arn
  role       = aws_iam_role.s3_replication_role.name
}

# Replication from primary to secondary
resource "aws_s3_bucket_replication_configuration" "primary_to_secondary" {
  provider = aws.us_east_1
  bucket   = aws_s3_bucket.primary.bucket

  role = aws_iam_role.s3_replication_role.arn

  rule {
    id     = "replication-rule-1"
    status = "Enabled"

    filter {
      prefix = ""  # All objects
    }

    destination {
      bucket        = "arn:aws:s3:::${aws_s3_bucket.secondary.bucket}"
      storage_class = "STANDARD"
    }
  }
}

# Replication from secondary to primary
resource "aws_s3_bucket_replication_configuration" "secondary_to_primary" {
  provider = aws.us_west_1
  bucket   = aws_s3_bucket.secondary.bucket

  role = aws_iam_role.s3_replication_role.arn

  rule {
    id     = "replication-rule-2"
    status = "Enabled"

    filter {
      prefix = ""  # All objects
    }

    destination {
      bucket        = "arn:aws:s3:::${aws_s3_bucket.primary.bucket}"
      storage_class = "STANDARD"
    }
  }
}
