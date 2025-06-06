# AWS Settings
aws_region         = "us-east-1"
aws_profile        = "default"

# VPC and Subnet Configuration
vpc_cidr           = "172.31.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"] 

public_subnets     = ["172.31.16.0/20", "172.31.32.0/20"]
private_subnets    = ["172.31.48.0/20", "172.31.64.0/20"]

# EC2 Instance Configuration
ami_id             = "ami-0e9bbd70d26d7cf4f"
instance_type      = "t2.micro"                
key_name           = "maaz-aws-server-key"

# RDS Configuration
db_username        = "maaz"
db_password        = "AWSrdspassword2025"

# Outputs from VPC module (filled by Terraform automatically, just keep empty list here)
vpc_id             = ""
public_subnet_ids  = []
private_subnet_ids = []

# Route53 Configuration (For domain and SSL setup)
route53_zone_id    = "Z09717712PWRD7XOA245F"
domain_name        = "devopsagent.online"