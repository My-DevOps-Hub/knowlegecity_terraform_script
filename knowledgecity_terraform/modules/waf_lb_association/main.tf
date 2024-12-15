resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = var.load_balancer_arn
  web_acl_arn  = var.waf_web_acl_arn
}