# AWS Region and Profile
variable "aws_region" {
  description = "The AWS region to deploy the infrastructure"
  type        = string
}

variable "aws_profile" {
  description = "The AWS CLI profile to use for authentication"
  type        = string
}

# VPC and Subnet Configuration
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets for the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets for the VPC"
  type        = list(string)
}

# EC2 Instances Configuration
variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instances"
  type        = string
}

variable "key_name" {
  description = "The SSH key name to access EC2 instances"
  type        = string
}

# RDS Configuration
variable "db_username" {
  description = "The username for the RDS databases"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS databases"
  type        = string
}

# Route53 and Domain Configuration
variable "route53_zone_id" {
  description = "The Route53 hosted zone ID"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the applications"
  type        = string
}

# SSL Configuration (ACM)
variable "acm_cert_arn" {
  description = "The ARN of the ACM certificate already issued for your domain"
  type        = string
}

# New Variables added for SSL and Nginx Configuration
variable "ssl_email" {
  description = "The email address used for SSL certificate renewal notifications (used with Certbot)"
  type        = string
}

# Metabase Application Configuration
variable "metabase_image" {
  description = "The Docker image for the Metabase BI tool"
  type        = string
  default     = "metabase/metabase"
}

variable "metabase_port" {
  description = "The port on which Metabase will run inside the Docker container"
  type        = number
  default     = 3000
}


variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}