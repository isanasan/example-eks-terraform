module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
 
  name = "${local.name_prefix}-vpc"
  cidr = "10.0.0.0/16"
 
  azs             = ["${local.region}a", "${local.region}c"]
  public_subnets  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnets = ["10.0.100.0/24", "10.0.101.0/24"]
 
  enable_nat_gateway = true
 
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
 
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}