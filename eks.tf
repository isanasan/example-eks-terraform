module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "18.31.2"

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

resource "aws_security_group_rule" "allow_ingress_port" {
  security_group_id        = module.eks.node_security_group_id
  type                     = "ingress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  source_security_group_id = module.eks.cluster_security_group_id
}
