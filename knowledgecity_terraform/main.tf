
#create VPC and subnets in primary region including route tables, Routes, IG, NAT Gateway's, EIP's  etc )
module "vpc_us_east_1" {
  source             = "./modules/vpc"
  providers          = { aws = aws.us_east_1 }
  vpc_name           = var.vpc_us_east_1_name
  cidr_block         = var.vpc_us_east_1_cidr
  availability_zones = var.availability_zones_us_east_1
  public_subnet_count = var.public_subnet_count_primary
  private_subnet_count = var.private_subnet_count_primary
  avaialability_zones_per_region =length(var.availability_zones_us_east_1)
  cluster_name =var.cluster_name_primary
}

#create VPC and subnets in secondary region including route tables, Routes, IG, NAT Gateway's, EIP's  etc )
module "vpc_us_west_1" {
  source             = "./modules/vpc"
  providers          = { aws = aws.us_west_1 }
  vpc_name           = var.vpc_us_west_1_name
  cidr_block         = var.vpc_us_west_1_cidr
  availability_zones = var.availability_zones_us_west_1
  public_subnet_count = var.public_subnet_count_secondary
  private_subnet_count = var.private_subnet_count_secondary
  avaialability_zones_per_region =length(var.availability_zones_us_west_1)
  cluster_name = var.cluster_name_secondary
}

#Get DB password stored in AWS Secret manager
data "aws_secretsmanager_secret_version" "db_master_password" {
  secret_id = "db-master-password_new" # Name or ARN of your secret
}

#auro global cluster
module "aurora" {
  source                    = "./modules/aurora"
  providers = {
      aws = aws.us_east_1
  }

  global_cluster_identifier = var.global_cluster_identifier
  engine_version            = var.engine_version
  master_username           = var.master_username
  master_password           = data.aws_secretsmanager_secret_version.db_master_password.secret_string
  database_name             = var.database_name
  primary_availability_zones = var.availability_zones_us_east_1
  secondary_availability_zones = var.availability_zones_us_west_1
  instance_class            = var.instance_class
  primary_instance_count    = var.primary_instance_count
  secondary_instance_count  = var.secondary_instance_count
  backup_retention_period   = var.backup_retention_period
  preferred_backup_window   = "02:00-03:00"
}

##########s3 buckets #########

#frontend1 primary s3 and frontend1 secondary s3 creation and enable 2 way replication
module "frontend_1" {
  source               = "./modules/s3_replication"
  providers = {
     aws = aws.us_west_1
  }
  primary_bucket_name  = var.primary_bucket_name_frontend1
  secondary_bucket_name = var.secondary_bucket_name_frontend1
}

#frontend2 primary s3 and frontend2 secondary s3 creation and enable 2 way replication
module "frontend_2" {
  source               = "./modules/s3_replication"
  providers = {
    aws = aws.us_west_1 
  }
  primary_bucket_name  = var.primary_bucket_name_frontend2
  secondary_bucket_name = var.secondary_bucket_name_frontend2
}

#media store primary s3 and media store secondary s3 creation and enable 2 way replication
module "media_store" {
  providers = {
     aws = aws.us_west_1
  }
  source               = "./modules/s3_replication"
  primary_bucket_name  = var.primary_bucket_name_media_store
  secondary_bucket_name = var.secondary_bucket_name_media_store
}


#multi region access point for frontend1
module "frontend1_mrap" {
  providers = {
     aws = aws.us_west_1
  }
  source               = "./modules/s3_mrap"
  mrap_name            = var.mrap_name_frontend1
  primary_bucket_arn   = "arn:aws:s3:::${var.primary_bucket_name_frontend1}"
  secondary_bucket_arn = "arn:aws:s3:::${var.secondary_bucket_name_frontend1}"
}

#multi region access point for frontend2
module "frontend2_mrap" {
  providers = {
     aws = aws.us_west_1
  }
  source               = "./modules/s3_mrap"
  mrap_name            = var.mrap_name_frontend2
  primary_bucket_arn   = "arn:aws:s3:::${var.primary_bucket_name_frontend2}"
  secondary_bucket_arn = "arn:aws:s3:::${var.secondary_bucket_name_frontend2}"
}

#multi region access point for encrypted media store
module "media_store_mrap" {
  providers = {
     aws = aws.us_west_1
  }
  source               = "./modules/s3_mrap"
  mrap_name            = var.mrap_name_media_store
  primary_bucket_arn   = "arn:aws:s3:::${var.primary_bucket_name_media_store}"
  secondary_bucket_arn = "arn:aws:s3:::${var.secondary_bucket_name_media_store}"
}

#s3 bucket to upload media files in primary region
module "media_upload_primary" {
  providers = {
     aws = aws.us_east_1
  }
  source      = "./modules/s3_bucket_module"
  bucket_name = var.bucket_name_primary
  region      = var.us_east_1_region
  versioning  = true
  tags = {
    Environment = "prod"
  }
}

#s3 bucket to upload media files in secondary region
module "media_upload_secondary" {
  providers = {
     aws = aws.us_west_1
  }
  source      = "./modules/s3_bucket_module"
  bucket_name = var.bucket_name_secondary
  region      = var.us_west_1_region
  versioning  = true
  tags = {
    Environment = "prod"
  }
}

#not using
# module "ec2_us_east_1" {
#   source             = "./modules/ec2"
#   providers          = { aws = aws.us_east_1 }
#   private_subnet_ids = module.vpc_us_east_1.private_subnet_ids
#   ami_id             = var.ami_id
#   instance_type      = var.instance_type
# }

# module "ec2_us_west_1" {
#   source             = "./modules/ec2"
#   providers          = { aws = aws.us_west_1 }
#   private_subnet_ids = module.vpc_us_west_1.private_subnet_ids
#   ami_id             = var.ami_id
#   instance_type      = var.instance_type
# }

##auto scaling group  primary region
module "asg_us_east_1" {
  source             = "./modules/asg"
  asg_name           = var.asg_name_primary
  desired_capacity   = var.desired_capacity_primary
  min_size           = var.min_size_primary
  max_size           = var.max_size_primary
  providers          = { aws = aws.us_east_1 }
  security_group_id  = module.security_group_asg_primary.security_group_id
  private_subnet_ids = module.vpc_us_east_1.private_subnet_ids
  ami_id             = var.ami_id
  instance_type      = var.instance_type
}

#auto scaling group  secondary region
module "asg_us_west_1" {
  source             = "./modules/asg"
  asg_name           = var.asg_name_secondary
  desired_capacity   = var.desired_capacity_secondary
  min_size           = var.min_size_secondary
  max_size           = var.max_size_secondary
  providers          = { aws = aws.us_west_1 }
  security_group_id  = module.security_group_asg_secondary.security_group_id
  private_subnet_ids = module.vpc_us_west_1.private_subnet_ids
  ami_id             = var.ami_id
  instance_type      = var.instance_type
}

#load balancer primary region
module "load_balancer_us_east_1" {
  source             = "./modules/load_balancer"
  lb_name            = var.lb_name_primary
  lb_target_group_name = var.lb_target_group_name_primary
  vpc_id             = module.vpc_us_east_1.vpc_id
  providers          = { aws = aws.us_east_1 }
  security_groups    = [module.security_group_lb_primary.security_group_id, module.security_group_lb_primary_1.security_group_id]
  subnets            = module.vpc_us_east_1.subnet_ids
}


#load balancer secondary region
module "load_balancer_us_west_1" {
  source             = "./modules/load_balancer"
  lb_name            = var.lb_name_secondary
  lb_target_group_name = var.lb_target_group_name_secondary
  vpc_id             = module.vpc_us_west_1.vpc_id
  providers          = { aws = aws.us_west_1 }
  security_groups    = [module.security_group_lb_secondary.security_group_id, module.security_group_lb_secondary_1.security_group_id]
  subnets            = module.vpc_us_west_1.subnet_ids
}

# Corss region VPC Peering
module "vpc_peering_us_east_1" {
  source             = "./modules/vpc_peering"
  providers          = { aws = aws.us_east_1 }
  vpc_id_requester   = module.vpc_us_east_1.vpc_id
  vpc_id_accepter    = module.vpc_us_west_1.vpc_id
  vpc_name_requester = var.vpc_us_east_1_name
  vpc_name_accepter  = var.vpc_us_west_1_name
  route_table_id_requester = module.vpc_us_east_1.public_route_table_id
  route_table_id_accepter  = module.vpc_us_west_1.public_route_table_id
  peer_vpc_cidr      = var.vpc_us_west_1_cidr
}

module "vpc_peering_us_west_1" {
  source             = "./modules/vpc_peering"
  providers          = { aws = aws.us_west_1 }
  vpc_id_requester   = module.vpc_us_west_1.vpc_id
  vpc_id_accepter    = module.vpc_us_east_1.vpc_id
  vpc_name_requester = var.vpc_us_west_1_name
  vpc_name_accepter  = var.vpc_us_east_1_name
  route_table_id_requester = module.vpc_us_west_1.public_route_table_id
  route_table_id_accepter  = module.vpc_us_east_1.public_route_table_id
  peer_vpc_cidr      = var.vpc_us_east_1_cidr
}

#Create EKS cluster and node groups in primary region
module "eks_us_east_1" {
  source           = "./modules/eks"
  providers        = { aws = aws.us_east_1 }
  cluster_name     = var.cluster_name_primary
  subnet_ids       = module.vpc_us_east_1.subnet_ids
  private_subnets  = module.vpc_us_east_1.private_subnet_ids
  desired_size     = var.desired_size_nodes_primary
  max_size         = var.max_size_nodes_primary
  min_size         = var.min_size_nodes_primary
}

#Create EKS cluster and node groups in secondary region
module "eks_us_west_1" {
  source           = "./modules/eks"
  providers        = { aws = aws.us_west_1 }
  cluster_name     = var.cluster_name_secondary
  subnet_ids       = module.vpc_us_west_1.subnet_ids
  private_subnets  = module.vpc_us_west_1.private_subnet_ids
  desired_size     = var.desired_size_nodes_secondary
  max_size         = var.max_size_nodes_secondary
  min_size         = var.min_size_nodes_primary
}

#attaching autoscaling group in primary region to primary region load balancer 
module "asg_lb_attachment_primary" {
  source = "./modules/asg_lb_attachment" 

  autoscaling_group_name = var.lb_name_primary
  lb_target_group_arn   = module.load_balancer_us_east_1.load_balancer_arn
}

#attaching autoscaling group in secondary region to secondary region load balancer 
module "asg_lb_attachment_secondary" {
  source = "./modules/asg_lb_attachment" 

  autoscaling_group_name = var.lb_name_secondary
  lb_target_group_arn   = module.load_balancer_us_west_1.load_balancer_arn
}

#cloudfront distribution frontend1 with WAF
module "cloudfront_frontend1" {
  source                = "./modules/cloudfront"
  mrap_alias            = module.frontend1_mrap.mrap_alias
  acm_certificate_arn   = var.acm_certificate_arn_frontend1
  cloudfront_price_class = var.cloudfront_price_class
  waf_web_acl_id = module.waf.waf_web_acl_arn
}

#cloudfront distribution frontend2 with WAF
module "cloudfront_frontend2" {
  source                = "./modules/cloudfront"
  mrap_alias            = module.frontend2_mrap.mrap_alias
  acm_certificate_arn   = var.acm_certificate_arn_frontend2
  cloudfront_price_class = var.cloudfront_price_class
  waf_web_acl_id = module.waf.waf_web_acl_arn
}

#cloudfront distribution media store with WAF
module "cloudfront_media_store" {
  source                = "./modules/cloudfront"
  mrap_alias            = module.media_store_mrap.mrap_alias
  acm_certificate_arn   = var.acm_certificate_arn_media_store
  cloudfront_price_class = var.cloudfront_price_class
  waf_web_acl_id = module.waf.waf_web_acl_arn
}

# create WAF
module "waf" {
  source           = "./modules/waf"
  waf_name         = var.waf_name
  waf_description  = var.waf_description
  allowed_ips      = var.allowed_ips # Replace with actual IPs
}

# associate waf with load balancer in primary region 
module "waf_lb_assocation_primary" {
  source = "./modules/waf_lb_association"
  load_balancer_arn = module.load_balancer_us_east_1.load_balancer_arn
  waf_web_acl_arn = module.waf.waf_web_acl_arn
}

# associate waf with load balancer in secondary region 
module "waf_lb_assocation_secondary" {
  source = "./modules/waf_lb_association"
  load_balancer_arn = module.load_balancer_us_west_1.load_balancer_arn
  waf_web_acl_arn = module.waf.waf_web_acl_arn
}
# create Private hosted zone for the Database
module "private_hosted_zone" {
  source = "./modules/private_hosted_zone"
  zone_name = var.private_hosted_zone_name
  vpc_1_id = module.vpc_us_east_1.vpc_id
  vpc_2_id = module.vpc_us_west_1.vpc_id
  comment = var.private_hosted_zone_comment
}

#adding primary write endpoint to route53 private hosted zone as a cname record
module "primary_write_endpoint_cname" {
  source = "./modules/route53"
  private_hosted_zone_id = module.private_hosted_zone.zone_id
  cname_record_name = var.cname_record_name_primary_write
  db_endpoint = module.aurora.primary_write_endpoint
}

#adding primary read endpoint to route53 private hosted zone as a cname record
module "primary_read_endpoint_cname" {
  source = "./modules/route53"
  private_hosted_zone_id = module.private_hosted_zone.zone_id
  cname_record_name = var.cname_record_name_primary_read
  db_endpoint = module.aurora.primary_reader_endpoint
}

#adding secondary read endpoint to route53 private hosted zone as a cname record
module "secondary_read_endpoint_cname" {
  source = "./modules/route53"
  private_hosted_zone_id = module.private_hosted_zone.zone_id
  cname_record_name = var.cname_record_name_secondary_read
  db_endpoint = module.aurora.secondary_reader_endpoint
}



#security group 1 for primary load balancer 
module "security_group_lb_primary" {
source = "./modules/security_groups"
security_group_name = var.primary-alb-security-group_name
security_group_description = var.primary-alb-security-group_description
vpc_id = module.vpc_us_east_1.vpc_id
}

#security group 2 for primary load balancer 
module "security_group_lb_primary_1" {
source = "./modules/security_groups"
security_group_name = var.primary-alb-security-group_1_name
security_group_description = var.primary-alb-security-group_1_description
vpc_id = module.vpc_us_east_1.vpc_id
}

#security group 1 for secondary load balancer 
module "security_group_lb_secondary" {
source = "./modules/security_groups"
security_group_name = var.secondary-alb-security-group_name
security_group_description = var.secondary-alb-security-group_description
vpc_id = module.vpc_us_west_1.vpc_id
}

#security group 2 for secondary load balancer 
module "security_group_lb_secondary_1" {
source = "./modules/security_groups"
security_group_name = var.secondary-alb-security-group_1_name
security_group_description = var.secondary-alb-security-group_1_description
vpc_id = module.vpc_us_west_1.vpc_id
}

#security group 1 for primary asg
module "security_group_asg_primary" {
source = "./modules/security_groups"
security_group_name =var.primary-asg-security-group_name
security_group_description = var.primary-asg-security-group_description
vpc_id = module.vpc_us_east_1.vpc_id
}

#security group 1 for secondary asg 
module "security_group_asg_secondary" {
source = "./modules/security_groups"
security_group_name = var.secondary-asg-security-group_name
security_group_description = var.secondary-asg-security-group_description
vpc_id = module.vpc_us_west_1.vpc_id
}