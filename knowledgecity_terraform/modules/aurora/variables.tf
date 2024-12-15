variable "global_cluster_identifier" {
  description = "The identifier for the global cluster."
  type        = string
}

variable "engine_version" {
  description = "Aurora MySQL engine version."
  type        = string
  default     = "8.0.mysql_aurora.3.03.0"
}

variable "master_username" {
  description = "Master username for the database."
  type        = string
}

variable "master_password" {
  description = "Master password for the database."
  type        = string
}

variable "database_name" {
  description = "The name of the default database to create."
  type        = string
}

variable "primary_availability_zones" {
  description = "Availability zones for the primary region."
  type        = list(string)
}

variable "secondary_availability_zones" {
  description = "Availability zones for the secondary region."
  type        = list(string)
}

variable "instance_class" {
  description = "The instance class for the database instances."
  type        = string
  default     = "db.r5.large"
}

variable "primary_instance_count" {
  description = "Number of instances in the primary region."
  type        = number
  default     = 4
}

variable "secondary_instance_count" {
  description = "Number of instances in the secondary region."
  type        = number
  default     = 4
}

variable "backup_retention_period" {
  description = "Number of days to retain backups."
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Preferred backup window."
  type        = string
  default     = "02:00-03:00"
}

variable "us_east_1_region" {
  description = "AWS region for the first VPC"
  default     = "us-east-1"
}

variable "us_west_1_region" {
  description = "AWS region for the second VPC"
  default     = "us-west-1"
}