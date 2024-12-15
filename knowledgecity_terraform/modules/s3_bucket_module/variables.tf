variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {}
}
