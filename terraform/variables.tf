variable "node_groups" {
  default = {

    prod_workers = {

      desired_capacity = 2
      max_capacity     = 4
      min_capacity     = 2
      name             = "prod_workers"
      instance_types   = ["t3.medium"]
      disk_size        = 100
      ami_type         = "AL2_x86_64"
      k8s_labels = {
        Environment = "prod_workers"
      }
      additional_tags = {
        Name = "prod_workers"
      }
    }
  }
}

# AWS Auth (kubernetes_config_map)

# variable "map_roles" {
#     description = "Additional IAM Roles to add to the aws-auth configmap."
#     type = list(object({
#         userarn  = string
#         username = string
#         groups   = list(string)
#     }))

#     default = [
#         {
#         rolearn  = ""
#         username = ""
#         groups   = [""]
#         },
#     ]
# }
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "760370564012"
      username = "devops-candidate2"
      groups   = ["system:masters"]
    },
  ]
}

