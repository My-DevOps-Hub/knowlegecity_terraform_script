variable "zone_name" {
  description = "Name of the private hosted zone (e.g., example.internal)"
  type        = string
}

variable "vpc_1_id" {
  description = "ID of the first VPC to associate with the private hosted zone"
  type        = string
}

variable "vpc_2_id" {
  description = "ID of the second VPC to associate with the private hosted zone"
  type        = string
}

variable "comment" {
  description = "Comment or description for the private hosted zone"
  type        = string
  default     = "Managed by Terraform"
}
