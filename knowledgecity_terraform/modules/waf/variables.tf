variable "waf_name" {
  description = "Name of the WAF Web ACL"
  type        = string
}

variable "waf_description" {
  description = "Description of the WAF Web ACL"
  type        = string
}

variable "allowed_ips" {
  description = "List of IP addresses to block"
  type        = list(string)
}
