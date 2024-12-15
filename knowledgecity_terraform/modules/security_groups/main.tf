# Create a security group for the load balancer
resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id  # Specify the VPC ID where the load balancer will be deployed

  # Inbound rules for the load balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic from any source
    description = "Allow inbound HTTP traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS traffic from any source
    description = "Allow inbound HTTPS traffic"
  }

  # Outbound rules for the load balancer (allowing all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

