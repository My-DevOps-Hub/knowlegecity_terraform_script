resource "aws_launch_configuration" "this" {
  name          = "launch-configuration-${var.asg_name}"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [var.security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.private_subnet_ids
  launch_configuration = aws_launch_configuration.this.id
  health_check_type    = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "0"

  tags = [
    {
      key                 = "Name"
      value               = var.asg_name
      propagate_at_launch = true
    }
  ]
}

