module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_endpoint_public_access = true

  cluster_version = "1.27"
  cluster_name    = "${local.name_prefix}-eks"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = true
  eks_managed_node_groups = {
    main = {
      desired_size   = 1
      instance_types = ["t3.medium"]
    }
  }
}
