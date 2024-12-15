variable "primary_bucket_name" {
  description = "Name of the primary S3 bucket"
  type        = string
}

variable "secondary_bucket_name" {
  description = "Name of the secondary S3 bucket"
  type        = string
}


variable "us_east_1_region" {
  description = "AWS region for the first VPC"
  default     = "us-east-1"
}

variable "us_west_1_region" {
  description = "AWS region for the second VPC"
  default     = "us-west-1"
}
