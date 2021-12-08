module "jenkins" {
  source = "terraform-module/release/helm"

  namespace  = "default"
  repository = "https://charts.jenkins.io"

  app = {
    name         = "jenkins"
    version      = "3.9.3"
    chart        = "jenkins"
    force_update = true
    wait         = false
    deploy       = 1
  }

  set = [
    {
      name  = "controller.serviceType"
      value = "LoadBalancer"
    },
    {
      name  = "controller.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
    },
    {
      name  = "controller.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
      value = "internal"
    }
  ]

  set_sensitive = [
    {
      path  = "controller.adminUser"
      value = "jenkins"
    }
  ]
}