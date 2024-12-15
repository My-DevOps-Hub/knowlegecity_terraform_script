resource "aws_route53_zone" "private_zone" {
  name         = var.zone_name
  comment      = var.comment

  # Associate the first VPC
  vpc {
    vpc_id = var.vpc_1_id
  }

  # Associate the second VPC
  vpc {
    vpc_id = var.vpc_2_id
  }
}
