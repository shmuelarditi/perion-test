# module "jenkins" {
#   source = "terraform-module/release/helm"

#   namespace  = "default"
#   repository = "https://charts.jenkins.io"

#   app = {
#     name         = "jenkins"
#     version      = "3.9.3"
#     chart        = "jenkins"
#     force_update = true
#     wait         = false
#     deploy       = 1
#   }

#   set = [
#     {
#       name  = "controller.serviceType"
#       value = "LoadBalancer"
#     },
#     {
#       name  = "controller.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
#       value = "nlb"
#     },
#     {
#       name  = "controller.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
#       value = "internal"
#     },
#     {
#       name  = "agent.tag"
#       value = "latest"
#     },
#     {
#       name  = "agent.iamge"
#       value = "ubuntu"
#     }
#   ]

#   set_sensitive = [
#     {
#       path  = "controller.adminUser"
#       value = "jenkins"
#     }
#   ]
# }

module "jenkins" {
  source  = "./modules/jenkins/"
  # insert the 1 required variable here
  create_namespace = true
  service_type = "LoadBalancer"
}

# module helloworld" {
#   source = "terraform-module/release/helm"

#   namespace  = "default"
#   repository = "https://helmcharts.opsmx.com/"

#   app = {
#     name         = "hello-world"
#     version      = "1.0.3"
#     chart        = "hello-kubernetes"
#     force_update = true
#     wait         = false
#     deploy       = 1
#   }

#   set = [
#     # {
#     #   name  = "controller.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
#     #   value = "nlb"
#     # },
#     # {
#     #   name  = "controller.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
#     #   value = "internal"
#     # },
#     # {
#     #   name  = "serviceType"
#     #   value = "LoadBalancer"
#     # }
#   ]
# }
