output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}



# Output Private Subnet IDs
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

# Output Subnet IDs (Public and Private)
output "subnet_ids" {
  value = aws_subnet.public[*].id
}

### to remove

output "public_route_table_id" {
  value = aws_route_table.public.id
}
