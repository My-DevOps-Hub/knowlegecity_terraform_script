resource "aws_wafv2_web_acl" "this" {
  name        = var.waf_name
  scope       = "CLOUDFRONT" # Always CLOUDFRONT for global distributions
  description = var.waf_description

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.waf_name
    sampled_requests_enabled   = true
  }

  # Add a rule to block bad bots
  rule {
    name     = "BlockBadBots"
    priority = 0

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockBadBots"
      sampled_requests_enabled   = true
    }
  }

  # Add an IP block rule
  rule {
    name     = "BlockSpecificIPs"
    priority = 1

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.example.arn
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockSpecificIPs"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_ip_set" "example" {
  name        = "${var.waf_name}-blocked-ips"
  scope       = "CLOUDFRONT"
  description = "IP set for blocking specific IPs"

  addresses = var.allowed_ips

  ip_address_version = "IPV4"
}
