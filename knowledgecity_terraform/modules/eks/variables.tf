variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnets for EKS"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets for EKS"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired size of the EKS Node Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the EKS Node Group"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the EKS Node Group"
  type        = number
}
