###############
##### EKS #####
###############

variable "node_groups" {
  description = "Managed node group configurations"
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

###################
##### Jenkins #####
###################

variable "request_storage" {
  description = "storage for your jenkins installation"
  default     = "5Gi"
}

variable "accessmode" {
  description = "access mode for jenkins persistent volume claim"
  default     = "ReadWriteOnce"
}

variable "name" {
  description = "name of your jenkins application, will be used as prefix for all manifests"
  default     = "jenkins"
}

variable "namespace" {
  description = "namespace where all the jenkins resources will be created"
  default     = "default"
}

variable "storageclass" {
  description = "storageclass to use for creating persistent volume claim, defaults to gp2 of AWS"
  default     = "gp2"
}

variable "create_namespace" {
  description = "to create the namespace or not"
  type        = bool
  default = false
}

variable "jenkins_image" {
  description = "docker image with the tag"
  default     = "jenkins/jenkins:lts-alpine"
}

variable "replicas" {
  description = "no. of replicas you want"
  default     = "1"
}

variable "service_type" {
  description = "type for the service"
  default     = "LoadBalancer"
}
