# Regions
variable "us_east_1_region" {
  description = "AWS region for the first VPC"
  default     = "us-east-1"
}

variable "us_west_1_region" {
  description = "AWS region for the second VPC"
  default     = "us-west-1"
}

# VPC configuration
variable "vpc_us_east_1_name" {
  description = "Name of the VPC in us-east-1"
  default     = "vpc-us-east-1"
}

variable "vpc_us_east_1_cidr" {
  description = "CIDR block for the VPC in us-east-1"
  default     = "10.0.0.0/16"
}

variable "vpc_us_west_1_name" {
  description = "Name of the VPC in us-west-1"
  default     = "vpc-us-west-1"
}

variable "vpc_us_west_1_cidr" {
  description = "CIDR block for the VPC in us-west-1"
  default     = "10.1.0.0/16"
}

variable "availability_zones_us_east_1" {
  description = "Availability zones for us-east-1"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "availability_zones_us_west_1" {
  description = "Availability zones for us-west-1"
  default     = ["us-west-1a", "us-west-1b"]
}


variable "ami_id" {
  description = "The AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "security_groups" {
  description = "The security group IDs for the load balancer"
  type        = list(string)
}

#### to remove
variable "cluster_us_east_1_name" { default = "eks-cluster-us-east-1" }
variable "cluster_us_west_1_name" { default = "eks-cluster-us-west-1" }

# variable "public_subnet_count" {
#   default = 2
# }

# variable "private_subnet_count" {
#   default = 2
# }

# public_subnet_count_primary = 2
# private_subnet_count_primary = 2
# public_subnet_count_secondary = 2
# private_subnet_count_secondary = 2

variable "public_subnet_count_primary" {
  default = 2
}
variable "private_subnet_count_primary" {
  default = 2
}
variable "public_subnet_count_secondary" {
  default = 2
}
variable "private_subnet_count_secondary" {
  default = 2
}

variable "primary_bucket_name_frontend1" {
  description = "primary_bucket_name_frontend1"
  type        = string
}

variable "secondary_bucket_name_frontend1" {
  description = "secondary_bucket_name_frontend1"
  type        = string
}

variable "primary_bucket_name_frontend2" {
  description = "primary_bucket_name_frontend2"
  type        = string
}

variable "secondary_bucket_name_frontend2" {
  description = "secondary_bucket_name_frontend2"
  type        = string
}

variable "primary_bucket_name_media_store" {
  description = "primary_bucket_name_media_store"
  type        = string
}

variable "secondary_bucket_name_media_store" {
  description = "secondary_bucket_name_media_store"
  type        = string
}

variable "mrap_name_frontend1" {
  description = "multi region access point frontend1"
  type        = string
}

variable "mrap_name_frontend2" {
  description = "multi region access point frontend2"
  type        = string
}

variable "mrap_name_media_store" {
  description = "multi region access point media store"
  type        = string
}

variable "bucket_name_primary" {
  description = "bucket name for media upload in primary region"
  type        = string
}

variable "bucket_name_secondary" {
  description = "bucket name for media upload in secondary region"
  type        = string
}

variable "engine_version" {
  description = "database engine version"
  type        = string
}

variable "master_username" {
  description = "master username"
  type        = string
}

variable "global_cluster_identifier" {
  description = "global cluster identifier"
  type        = string
}

variable "database_name" {
  description = "database name"
  type        = string
}

variable "instance_class" {
  description = "What instance class to use for the Database"
  type        = string
}

variable "primary_instance_count" {
  description = "DB primary instance count "
  default = 2
}

variable "secondary_instance_count" {
  description = "DB Secondary instance count"
  default = 2
}

variable "backup_retention_period" {
  description = "backup rentention period"
  default = 7 
}


variable "lb_name_primary" {
  description = "Primary Load balancer name"
  type        = string
}

variable "lb_target_group_name_primary" {
  description = "Primary target group name"
  type        = string
}

variable "lb_name_secondary" {
  description = "secondary load balancer name "
  type        = string
}

variable "lb_target_group_name_secondary" {
  description = "secondary target group name "
  type        = string
}

variable "asg_name_primary" {
  description = "auto sacling group name primary "
  type        = string
}


variable "desired_capacity_primary" {
  description = "desired_capacity_primary"
  default = 2 
}
variable "min_size_primary" {
  description = "min_size_primary"
  default = 2
}
variable "max_size_primary" {
  description = "max_size_primary"
  default = 4 
}

variable "asg_name_secondary" {
  description = "auto sacling group name secondary "
  type        = string
}


variable "desired_capacity_secondary" {
  description = "desired_capacity_secondary"
  default = 2 
}

variable "min_size_secondary" {
  description = "min_size_secondary"
  default = 2
}

variable "max_size_secondary" {
  description = "max_size_secondary"
  default = 4 
}


variable "cluster_name_primary" {
  description = "primary cluster name "
  type        = string
}

variable "desired_size_nodes_primary" {
  description = "primary desired node count"
  default = 2 
}

variable "max_size_nodes_primary" {
  description = "primary maximum node count"
  default = 3 
}

variable "min_size_nodes_primary" {
  description = "primary minimum node count"
  default = 1
}

variable "cluster_name_secondary" {
  description = "auto sacling group name primary "
  type        = string
}
variable "desired_size_nodes_secondary" {
  description = "secondary desired node count"
  default = 2
}

variable "max_size_nodes_secondary" {
  description = "secondary maximum node count"
  default = 3
}

variable "min_size_nodes_secondary" {
  description = "secondary minimum node count"
  default = 1
}

variable "acm_certificate_arn_frontend1" {
  description = "The ARN of the ACM certificate for CloudFront HTTPS"
  type        = string
}

variable "acm_certificate_arn_frontend2" {
  description = "The ARN of the ACM certificate for CloudFront HTTPS"
  type        = string
}

variable "acm_certificate_arn_media_store" {
  description = "The ARN of the ACM certificate for CloudFront HTTPS"
  type        = string
}

variable "cloudfront_price_class" {
  description = "The price class for the CloudFront distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "waf_name" {
  description = "Name of the WAF Web ACL"
  type        = string
}

variable "waf_description" {
  description = "Description of the WAF Web ACL"
  type        = string
  default     = "WAF Web ACL for CloudFront"
}

variable "allowed_ips" {
  description = "List of IP addresses to block"
  type        = list(string)
}


variable "private_hosted_zone_name" {
  description = "Name of the private hosted zone (e.g., example.internal)"
  type        = string
}

variable "private_hosted_zone_comment" {
  description = "Comment or description for the private hosted zone"
  type        = string
}

variable "cname_record_name_primary_read" {
  description = "cname_record_name_primary_read"
  type        = string
}

variable "cname_record_name_primary_write" {
  description = "cname_record_name_primary_write"
  type        = string
}

variable "cname_record_name_secondary_read" {
  description = "name_record_name_secondary_write"
  type        = string
}

##########
variable "primary-alb-security-group_name" {
  description = "primary-alb-security-group_name"
  type        = string
}

variable "primary-alb-security-group_1_name" {
  description = "primary-alb-security-group_1_name"
  type        = string
}

variable "primary-alb-security-group_description" {
  description = "primary-alb-security-group_description"
  type        = string
}

variable "primary-alb-security-group_1_description" {
  description = "primary-alb-security-group_1_description"
  type        = string
}

variable "secondary-alb-security-group_name" {
  description = "secondary-alb-security-group_name"
  type        = string
}

variable "secondary-alb-security-group_1_name" {
  description = "secondary-alb-security-group_1_name"
  type        = string
}

variable "secondary-alb-security-group_description" {
  description = "secondary-alb-security-group_description"
  type        = string
}

variable "secondary-alb-security-group_1_description" {
  description = "secondary-alb-security-group_1_description"
  type        = string
}

variable "primary-asg-security-group_name" {
  description = "primary-asg-security-group_name"
  type        = string
}


variable "primary-asg-security-group_description" {
  description = "primary-asg-security-group_description"
  type        = string
}


variable "secondary-asg-security-group_name" {
  description = "secondary-asg-security-group_name"
  type        = string
}


variable "secondary-asg-security-group_description" {
  description = "secondary-asg-security-group_description"
  type        = string
}

