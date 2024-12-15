resource "aws_vpc_peering_connection" "this" {
  vpc_id        = var.vpc_id_requester
  peer_vpc_id   = var.vpc_id_accepter
  auto_accept   = true  # Set to true if the peer VPC should automatically accept the peering

  tags = {
    Name = "${var.vpc_name_requester}-${var.vpc_name_accepter}-peering"
  }
}

# Route tables for requester and accepter VPCs
resource "aws_route" "requester_vpc" {
  route_table_id         = var.route_table_id_requester
  destination_cidr_block = var.peer_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter_vpc" {
  route_table_id         = var.route_table_id_accepter
  destination_cidr_block = var.peer_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

