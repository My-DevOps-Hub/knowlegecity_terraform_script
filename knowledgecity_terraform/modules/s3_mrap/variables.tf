variable "mrap_name" {
  description = "The name of the Multi-Region Access Point"
  type        = string
}

variable "primary_bucket_arn" {
  description = "ARN of the primary bucket"
  type        = string
}

variable "secondary_bucket_arn" {
  description = "ARN of the secondary bucket"
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