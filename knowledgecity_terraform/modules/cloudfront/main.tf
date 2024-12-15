resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.mrap_alias
    origin_id   = "MRAPOrigin"

    s3_origin_config {
      origin_access_identity = ""  # Replace with the ARN of an origin access identity if needed
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "MRAPOrigin"
    viewer_protocol_policy = "redirect-to-https"
    
    # Required fields
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # Required restrictions block
  restrictions {
    geo_restriction {
      restriction_type = "none"  # Change this if you want to restrict access
    }
  }

  price_class = var.cloudfront_price_class

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method   = "sni-only"
  }

 # Associate WAF Web ACL
  web_acl_id = var.waf_web_acl_id
}

