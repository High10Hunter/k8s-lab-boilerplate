module "vpc" {
  source              = "../../modules/vpc"
  environment         = local.environment
  project_id          = local.project_id
  region              = local.region
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.0.0/19"
  private_subnet_cidr = "10.0.32.0/19"
  secondary_ip_ranges = local.secondary_ip_ranges
}

module "gke" {
  source              = "../../modules/gke"
  environment         = local.environment
  project_id          = local.project_id
  region              = local.region
  cluster_name        = "${local.environment}-demo"
  vpc_id              = module.vpc.vpc_id
  private_subnet_id   = module.vpc.private_subnet_id
  secondary_ip_ranges = local.secondary_ip_ranges
  gke_machine_type    = "e2-medium"
  min_node_count      = 1
  max_node_count      = 5
}
