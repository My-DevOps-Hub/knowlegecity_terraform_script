variable "autoscaling_group_name" {
  description = "The name of the auto scaling group."
  type        = string
}

variable "lb_target_group_arn" {
  description = "The ARN of the load balancer target group."
  type        = string
}
