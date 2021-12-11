data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  vpc_id                               = module.vpc.vpc_id
  subnets                              = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access_cidrs = local.private_eks_access_cidrs
  cluster_create_endpoint_private_access_sg_rule = true

  # Managed Node Groups
  node_groups = var.node_groups

  # AWS Auth (kubernetes_config_map)
  #   map_roles = var.map_roles
  map_users = var.map_users
}

# resource "null_resource" "cluster_metrics" {
#   depends_on = [
#     module.eks
#   ]

#   provisioner "local-exec" {
#     command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
#   }
# }

output "cluster_access" {
  value = module.eks.config_map_aws_auth
}

