variable "private_hosted_zone_id" {
  description = "private hosted zone id"
  type        = string
}

variable "cname_record_name" {
  description = "name of the cname record"
  type        = string
}

variable "db_endpoint" {
  description = "endpoints of the database"
  type        = string
}
