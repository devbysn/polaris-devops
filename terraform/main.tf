resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name         = "polaris-vpc"
  cidr             = "10.0.0.0/16"
  azs              = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gw    = true
  single_nat_gw    = true
  enable_dns_hosts = true
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = "polaris-eks-${random_string.suffix.result}"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
}

module "jenkins" {
  source = "./modules/jenkins"

  cluster_name = module.eks.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnets
}
