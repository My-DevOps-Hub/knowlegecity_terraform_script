variable "private_subnet_ids" {
  description = "The list of private subnet IDs to launch EC2 instances in."
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to launch."
  type        = string
}
