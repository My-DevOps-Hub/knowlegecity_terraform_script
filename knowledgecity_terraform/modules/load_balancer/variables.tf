variable "vpc_id" {
  description = "The VPC ID where the load balancer will be created."
  type        = string
}

variable "security_groups" {
  description = "The security groups to assign to the load balancer."
  type        = list(string)
}

variable "subnets" {
  description = "The subnets for the load balancer."
  type        = list(string)
}

variable "lb_name" {
  description = "The name of the load balancer."
  type        = string
}

variable "lb_target_group_name" {
  description = "The name of the target group."
  type        = string
}
