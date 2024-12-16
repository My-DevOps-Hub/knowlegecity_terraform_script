# VPC realted changes

# us-east-1-region
us_east_1_region = "us-east-1"
# us-east-1-region
us_west_1_region = "us-west-1"
# VPC names and CIDR
vpc_us_east_1_name = "east-vpc"
vpc_us_east_1_cidr = "10.0.0.0/16"
vpc_us_west_1_name = "west-vpc"
vpc_us_west_1_cidr = "10.1.0.0/16"
#availability zones of us-east-1 and us-east-2
availability_zones_us_east_1 = ["us-east-1a", "us-east-1b"]
availability_zones_us_west_1  = ["us-west-1a", "us-west-1b"]
#number of public subnets and private subnets needed for each VPC 
public_subnet_count_primary = 2
private_subnet_count_primary = 2
public_subnet_count_secondary = 2
private_subnet_count_secondary = 2

security_groups = ["sg-xxxxxxxx", "sg-yyyyyyyy"]

#Ubuntu ami caompatible with PHP
ami_id = "ami-0e2c8caa4b6378d8c"
instance_type ="t3.large"


#S3 Replication related frontend (React and svelte) and media buckets with 2 way replication (You may not be able to use these values given if bucketsare there with that name already so make changes as required )

primary_bucket_name_frontend1  = "frontend1-primary" 
secondary_bucket_name_frontend1 = "frontend1-secondary"
primary_bucket_name_frontend2  = "frontend2-primary"
secondary_bucket_name_frontend2 = "frontend2-secondary"
primary_bucket_name_media_store  = "media-store-primary"
secondary_bucket_name_media_store = "media-store-secondary"

#multi region access point related changes
mrap_name_frontend1           = "frontend1-mrap"
mrap_name_frontend2           = "frontend2-mrap"
mrap_name_media_store         = "media-store-mrap"

#media upload bucket related changes
bucket_name_primary = "s3-media-upload-primary"
bucket_name_secondary = "s3-media-upload-secondary"

# Aurora Global Database related changes
#create a secret in AWS secret Manager using follwing command to store the database password 
#(As a best practice we are storing sesitive data like database passwords in aws secret manager)
# Command - aws secretsmanager create-secret --name db-master-password_new --secret-string '{"password":"password123"}'
# after creating you can check using 
# command - aws secretsmanager get-secret-value --secret-id db-master-password_new
engine_version            = "8.0.mysql_aurora.3.03.0"
master_username           = "admin"
global_cluster_identifier = "global-mysql-cluster"
database_name             = "mydatabase"
instance_class            = "db.r5.large"
primary_instance_count    = "2"
secondary_instance_count  = "2"
backup_retention_period   = "7"

#Load balancer related changes 
#Primary region ( load balancer name and target group name)
lb_name_primary                 = "primary-lb"
lb_target_group_name_primary    = "primary-tg"
#Secondary region ( load balancer name and target group name)
lb_name_secondary               = "secondary-lb"
lb_target_group_name_secondary  = "secondary-tg"

#Auto scaling group related changes
#Primary region Auto scaling group related changes ( name, min instance count, max instance count, desired instance count )
asg_name_primary                = "asg_primary"
desired_capacity_primary        = "2"
min_size_primary                = "2"
max_size_primary                = "4"
#Secondary region Auto scaling group related changes ( name, min instance count, max instance count, desired instance count )
asg_name_secondary              = "asg_secondary"
desired_capacity_secondary      = "2"
min_size_secondary              = "2"
max_size_secondary              = "4"

#EKS Cluster related changes
#EKS cluster primary region ( name, desired min and max node count (node group))
cluster_name_primary           = "eks-us-east-1"
desired_size_nodes_primary     = "2"
max_size_nodes_primary         = "3"
min_size_nodes_primary         = "1"
#EKS cluster Secondary region ( name, desired min and max node count (node group))
cluster_name_secondary           = "eks-us-west-1"
desired_size_nodes_secondary   = "2"
max_size_nodes_secondary       = "3"
min_size_nodes_secondary       = "1"

#Cloudfront related changes for multi region access points
#Create ACM certificates for 2 frontends and for the content in the media store using aws certificate manager and get the ACM certifcate arns and update here
acm_certificate_arn_frontend1   = "arn:aws:acm:us-east-1:123456789012:certificate/abcd-efgh-ijkl-mnop"
acm_certificate_arn_frontend2  = "arn:aws:acm:us-east-1:123456789012:certificate/xyzs-efgh-ijkl-mnop"
acm_certificate_arn_media_store = "arn:aws:acm:us-east-1:123456789012:certificate/xjjs-ffgh-ippl-mnop"
cloudfront_price_class = "PriceClass_100"

#Using one cloudfront fistribution for all 3 cloudfront distributions and load balancers
#Benefits of Using a Single WAF Web ACL for Multiple Distributions:
##Consistency: All CloudFront distributions will share the same set of rules, ensuring uniform protection.
#Cost-Effective: You pay for the WAF rules only once, regardless of the number of CloudFront distributions it is attached to.
#Simplified Management: Updating a single WAF Web ACL will propagate the changes to all attached CloudFront distributions.
waf_name        = "my-cloudfront-waf"
waf_description = "WAF for CloudFront Distribution and load balancers"
allowed_ips =  ["192.168.0.1/32", "10.10.113.0/24", "203.0.113.0/24" ,"172.0.112.0/24" ]


#private hosted zone related changes 
#Monolith application and the other applications that access the database should be able use two endpoints to write and read data seprately
private_hosted_zone_name = "database.internal"
private_hosted_zone_comment = "Private hosted zone for primary and secondary VPCs"


#make following changes to add reader endpoits and write endpoints to route 53 as CNAME records
cname_record_name_primary_read = "primary-read.database.internal"
cname_record_name_primary_write = "primary-write.database.internal"
cname_record_name_secondary_read = "secondary-read.database.internal"



primary-alb-security-group_name = "primary-alb-security-group_1"
primary-alb-security-group_1_name = "primary-alb-security-group_2"
primary-alb-security-group_description = "security group 1 of the primary alb"
primary-alb-security-group_1_description = "security group 2 of the primary alb"

secondary-alb-security-group_name = "secondary-alb-security-group_1"
secondary-alb-security-group_1_name = "secondary-alb-security-group_2"
secondary-alb-security-group_description = "security group 1 of the secondary alb"
secondary-alb-security-group_1_description = "security group 2 of the secondary alb"

primary-asg-security-group_name = "primary-asg-security-group_1"
primary-asg-security-group_description = "security group 1 of the primary asg"

secondary-asg-security-group_name = "secondary-asg-security-group_1"
secondary-asg-security-group_description = "security group 1 of the secondary asg"

