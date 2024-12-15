variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "public_subnet_count" {
  default = 2
}

variable "private_subnet_count" {
  default = 2
}

# variable "avaialability_zones_per_region" {
#   default = 2
# }
variable "avaialability_zones_per_region" {
  # default = 2
}

variable "cluster_name" {
  description = "EKS cluster name for tags"
  type        = string
}
