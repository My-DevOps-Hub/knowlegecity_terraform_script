variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type."
  type        = string
}

variable "desired_capacity" {
  description = "The desired number of EC2 instances."
  type        = number
}

variable "max_size" {
  description = "The maximum size of the ASG."
  type        = number
}

variable "min_size" {
  description = "The minimum size of the ASG."
  type        = number
}

variable "private_subnet_ids" {
  description = "The private subnets where EC2 instances will be launched."
  type        = list(string)
}

variable "asg_name" {
  description = "Name for the ASG."
  type        = string
}

variable "security_group_id" {
  description = "security group id"
  type        = string
}