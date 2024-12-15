variable "mrap_alias" {
  description = "The alias of the Multi-Region Access Point"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for CloudFront HTTPS"
  type        = string
}

variable "cloudfront_price_class" {
  description = "The price class for the CloudFront distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "waf_web_acl_id" {
  description = "The ARN of the WAF Web ACL to associate with CloudFront"
  type        = string
}