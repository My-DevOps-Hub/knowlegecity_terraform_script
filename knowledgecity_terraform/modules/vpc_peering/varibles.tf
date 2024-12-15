variable "vpc_id_requester" {
  description = "ID of the requester VPC (e.g., vpc_us_east_1)"
  type        = string
}

variable "vpc_id_accepter" {
  description = "ID of the accepter VPC (e.g., vpc_us_west_1)"
  type        = string
}

variable "vpc_name_requester" {
  description = "Name of the requester VPC"
  type        = string
}

variable "vpc_name_accepter" {
  description = "Name of the accepter VPC"
  type        = string
}

variable "route_table_id_requester" {
  description = "Route table ID of the requester VPC"
  type        = string
}

variable "route_table_id_accepter" {
  description = "Route table ID of the accepter VPC"
  type        = string
}

variable "peer_vpc_cidr" {
  description = "CIDR block of the peer VPC"
  type        = string
}
