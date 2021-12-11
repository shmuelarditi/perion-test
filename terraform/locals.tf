locals {
  #### EKS CLUSTER ####
  cluster_name    = "Perion-Shmuel-EKS"
  cluster_version = "1.20"
  private_eks_access_cidrs = ["85.250.224.206/32"]

  #### VPC ####
  region          = "eu-west-1"
  vpc_name        = "Perion-shmuel-vpc"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]
}