provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["ap-south-1a", "ap-south-1b"]
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source = "./modules/eks"

  cluster_name     = var.cluster_name
  cluster_version  = "1.29"
  subnet_ids       = module.vpc.private_subnets
  vpc_id           = module.vpc.vpc_id
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.nodegroup_role_arn
}
