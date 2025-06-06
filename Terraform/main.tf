# VPC Module from Terraform Registry
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "devops-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway     = true
  enable_dns_hostnames   = true

  tags = {
    Name = "devops-vpc"
  }
}