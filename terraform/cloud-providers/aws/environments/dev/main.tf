module "vpc" {
  source             = "../../modules/vpc"
  environment        = local.environment
  vpc_cidr_block     = "10.1.0.0/16"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "eks" {
  source      = "../../modules/eks"
  environment = local.environment
  eks_name    = local.eks_name
  eks_version = local.eks_version
  subnet_ids  = module.vpc.private_subnet_ids
}

module "helm" {
  source     = "./helm-charts"
  depends_on = [module.eks]
}
