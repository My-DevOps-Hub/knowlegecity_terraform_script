
resource "aws_rds_global_cluster" "aurora_global" {
  global_cluster_identifier = var.global_cluster_identifier
  engine                    = "aurora-mysql"
}

resource "aws_rds_cluster" "primary" {
  provider = aws.us_east_1
  cluster_identifier          = "${var.global_cluster_identifier}-primary"
  global_cluster_identifier   = aws_rds_global_cluster.aurora_global.id
  engine                      = "aurora-mysql"
  engine_version              = var.engine_version
  master_username             = var.master_username
  master_password             = var.master_password
  database_name               = var.database_name
  availability_zones          = var.primary_availability_zones
  backup_retention_period     = var.backup_retention_period
  preferred_backup_window     = var.preferred_backup_window
  skip_final_snapshot         = true
}

resource "aws_rds_cluster_instance" "primary_instances" {
  provider = aws.us_east_1
  count               = var.primary_instance_count
  identifier          = "${var.global_cluster_identifier}-primary-${count.index}"
  cluster_identifier  = aws_rds_cluster.primary.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.primary.engine
  publicly_accessible = false
}

resource "aws_rds_cluster" "secondary" {

  provider                  = aws.us_west_1
  cluster_identifier        = "${var.global_cluster_identifier}-secondary"
  global_cluster_identifier = aws_rds_global_cluster.aurora_global.id
  engine                    = "aurora-mysql"
  engine_version            = var.engine_version
  master_username           = var.master_username
  master_password           = var.master_password
  database_name             = var.database_name
  availability_zones        = var.secondary_availability_zones
  skip_final_snapshot       = true
}

resource "aws_rds_cluster_instance" "secondary_instances" {
  provider          = aws.us_west_1
  count               = var.secondary_instance_count
  identifier          = "${var.global_cluster_identifier}-secondary-${count.index}"
  cluster_identifier  = aws_rds_cluster.secondary.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.secondary.engine
  publicly_accessible = false
}



