terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Create VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

############################

resource "aws_subnet" "public" {
  count = var.public_subnet_count

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)

  tags = merge(
    {
      Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
    },
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned",
      "kubernetes.io/role/elb"            = "1"
    }
  )
}


resource "aws_subnet" "private" {
  count = var.private_subnet_count

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index + 2)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    {
      Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
    },
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned",
      "kubernetes.io/role/internal-elb"            = "1"
    }
  )
}

resource "aws_eip" "nat" {
  count = var.avaialability_zones_per_region

  vpc = true

  tags = {
    Name = "${var.vpc_name}-nat-eip-${count.index + 1}"
  }
}

# NAT Gateways
resource "aws_nat_gateway" "nat" {
  count         = var.avaialability_zones_per_region
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "${var.vpc_name}-nat-gateway-${count.index + 1}"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Tables (one for each AZ)
resource "aws_route_table" "private" {
  count  = var.avaialability_zones_per_region
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-private-rt-${count.index + 1}"
  }
}

# Associate Private Subnets with Private Route Tables
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = element(aws_route_table.private.*.id, floor(count.index / 2))
}


# Routes for Public Route Table
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Routes for Private Route Tables
resource "aws_route" "private_nat" {
  count                  = length(aws_route_table.private)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, floor(count.index / 2))
}

